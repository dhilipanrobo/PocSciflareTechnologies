//
//  Add User Controller.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import Foundation
import CoreData

class AddUserController : ObservableObject {
    let coreDataManager = CoreDataManager()
    let context = PersistenceController.shared.container.viewContext
    
    @Published var  param = [String:Any]()
    @Published var users = [userListBase]()
    @Published  var showAlert = false
    @Published  var alertMessage = ""
    func load(param : [String:Any]) async {
        await addUser(param:param)
    }
    
    func getUserLoad() async {
        await getUserList()
    }
    
    @MainActor func addUser(param : [String:Any]) async {
        ApiManager.postData(api: "\(devUrl())", param: param) { response in
            print("Response:\(response.description)")
        } failure: { Error in
            print("Error\(Error.localizedDescription)")
        }
    }
    
    @MainActor func getUserList() async {
        ApiManager.getData(api: "\(devUrl())") {[self] response in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([userListBase].self, from: response)
                users = responseModel
                Task{
                    await saveUsersToCoreData()
                }
            }catch{}
        } failure: { Error in
      }
    }
    //MARK: - Save coredata
    func saveUsersToCoreData()async {
        
        for user in users {
            print("id:\(user._id ?? "")")
            if !userExists(withID: user._id ?? "") {
                coreDataManager.saveUser(name: user.name ?? "", email: user.email ?? "", mobileNumber: user.mobile ?? "", gender: user.gender ?? "", id: user._id ?? "")
            }
        }
    }
    
    func userExists(withID id:String) -> Bool {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id )
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to fetch user: \(error)")
            return false
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
