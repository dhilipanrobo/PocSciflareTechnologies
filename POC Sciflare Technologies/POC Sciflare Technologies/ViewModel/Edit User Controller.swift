//
//  Edit User Controller.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import Foundation

import Foundation
import CoreData

class EditUserController : ObservableObject {
    let coreDataManager = CoreDataManager()
    @Published var  param = [String:Any]()
    @Published  var showAlert = false
    @Published  var alertMessage = ""
    
    func load(param : [String:Any],id:String) async {
        await UpdateUser(param:param,id: id)
    }
    func categoryLoad() async {
        await getCategoryList()
    }
    
    @MainActor func UpdateUser(param : [String:Any],id:String) async {
        ApiManager.putData(api: "\(devUrl())/\(id)", param: param) { response in
            print("Response:\(response.description)")
        } failure: { Error in
            print("Error\(Error.localizedDescription)")
        }
    }
    
    @MainActor func getCategoryList() async {
        ApiManager.getData(api: "\(devUrl())") {[self] response in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([userListBase].self, from: response)
                if  !responseModel.isEmpty {
                    saveUsersToCoreData(users: responseModel)
                }
            }catch{}
        } failure: { Error in
        }
    }
    
    private func saveUsersToCoreData(users: [userListBase]) {
        for user in users {
            coreDataManager.saveUser(name: user.name ?? "", email: user.email ?? "", mobileNumber: user.mobile ?? "", gender: user.gender ?? "", id: user._id ?? "")
        }
        
    }
    //MARK: - Validate User
    func validateUser(name:String,email:String, mobileNumber:String,gender:String) -> Bool {
        if name.isEmpty {
            alertMessage = "Please enter a name."
            showAlert = true
            return false
        }
        if email.isEmpty {
            alertMessage = "Please enter a Email."
            showAlert = true
            return false
        }
        
        if validateEmail(email: email){
            alertMessage = "Please enter a valied email id."
            showAlert = true
            return false
        }
    
        if mobileNumber.isEmpty {
            alertMessage = "Please enter a mobile number."
            showAlert = true
            return false
        }
        if validatePhoneNumber(phoneNumber: mobileNumber){
            alertMessage = "Please enter a valied 10 digit mobile number."
            showAlert = true
            return false
        }
        if gender.isEmpty {
            alertMessage = "Please enter a description."
            showAlert = true
            return false
        }
        return true
    }
   
}
