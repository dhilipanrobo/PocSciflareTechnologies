//
//  AddUserView.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import SwiftUI
struct AddUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var  addUserController : AddUserController
    @State  var name:String = ""
    @State  var email:String = ""
    @State  var mobileNumber:String = ""
    @State  var gender:String = "Male"
    @State  var genderList = ["Male","Femail","Other"]
    @State  var showAlert = false
    @State  var alertMessage = ""
    @State private var userEntity :[UserEntity] = [UserEntity]()
    @State var isValideUser = false
    let coreDataManager = CoreDataManager()
   
    var body: some View {
        NavigationView {
            VStack{
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
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
                            if addUserController.validateUser(name: name, email: email, mobileNumber: mobileNumber, gender: gender){
                                let param = ["name":name,"email":email,"mobile":mobileNumber,"gender":gender]
                                await addUserController.load(param: param)
                                await addUserController.getUserLoad()
                                userEntity = coreDataManager.fetchUser()
                                name = ""
                                email=""
                                mobileNumber=""
                            }else{
                                showAlert = addUserController.showAlert
                                alertMessage = addUserController.alertMessage
                            }
                        }catch{
                            print(error)
                        }
                    }
                }) {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding()
                
            }.navigationTitle("Add New User")
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }.task{
            
                await addUserController.getUserLoad()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
