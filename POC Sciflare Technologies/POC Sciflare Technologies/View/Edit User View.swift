//
//  Edit User View.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import SwiftUI

import SwiftUI
struct EditUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var editUserController : EditUserController
    let coreDataManager = CoreDataManager()
    var user : UserEntity
    @State  var name:String = ""
    @State  var email:String = ""
    @State  var mobileNumber:String = ""
    @State  var gender:String = ""
    @State  var genderList = ["Male","Femail","Other"]
    @State  var showAlert = false
    @State  var alertMessage = ""
    @State private var userEntity :[UserEntity] = [UserEntity]()
    
    
    init(user: UserEntity) {
        self.user = user
        _name = State(initialValue: user.name ?? "")
        _email = State(initialValue: user.email ?? "")
        _mobileNumber = State(initialValue: user.mobile ?? "")
        _gender = State(initialValue: user.gender ?? "")
    }
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Update User")
                    .bold()
                    .font(.largeTitle)
                Form {
                    TextField("Name",text: $name)
                    TextField("Email",text: $email).keyboardType(.emailAddress)
                    TextField("Mobile",text: $mobileNumber).keyboardType(.phonePad)
                    
                    Picker("Gender", selection: $gender) {
                        ForEach (genderList,id:\.self){category in
                            Text("\(category)").tag( "\(category)")
                        }
                    }
                }.background(Color.white)
                
                Button(action: {
                    Task{
                        do{
                            if editUserController.validateUser(name: name, email: email, mobileNumber: mobileNumber, gender: gender){
                                let param = ["name":name,"email":email,"mobile":mobileNumber,"gender":gender]
                                print(param)
                                user.name = name
                                user.email = email
                                user.gender = gender
                                user.mobile = mobileNumber
                                coreDataManager.updateUser()
                                await editUserController.load(param: param, id: user.id ?? "")
                                name = ""
                                email=""
                                mobileNumber=""
                            }else{
                                alertMessage = editUserController.alertMessage
                                showAlert = editUserController.showAlert
                            }
                        }catch{
                            print(error)
                        }
                    }
                }) {
                    Text("Update")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding()
                
            }.navigationBarHidden(true)
                .navigationTitle("")
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }.onAppear {
            UITableView.appearance().backgroundColor = UIColor.white
        }
        .task {
            name = user.name ?? ""
        }
    }
}

