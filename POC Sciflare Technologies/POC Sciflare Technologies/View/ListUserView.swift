//
//  ListUserView.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import SwiftUI

struct ListUserView: View {
    @EnvironmentObject private var listUserController : ListUserController
    @State private var userEntityList :[UserEntity] = [UserEntity]()
    var body: some View {
        NavigationView {
            List {
                ForEach(userEntityList, id:\.self) { user in
                    
                    NavigationLink(destination: EditUserView(user: user).environmentObject(EditUserController())) {
                        CardView(name:user.name ?? "" , email: user.email ?? "", gender: user.gender ?? "" , mobile: user.mobile ?? "")
                    }
                }
            }.task {
                listUserController.load()
                userEntityList = listUserController.userEntity
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    ListUserView()
}
