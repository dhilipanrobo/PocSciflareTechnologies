//
//  RootView.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        let addUserController = AddUserController()
        let listUserController = ListUserController()
        TabView {
            AddUserView().environmentObject(addUserController)
                .tabItem {
                    Image(systemName: "person.crop.circle.badge.plus")
                    Text("Add User")}
            
            ListUserView().environmentObject(listUserController)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")}
            LocationView()
                .tabItem {
                    Image(systemName: "location.circle.fill")
                    Text("Location")
            }
        }
    }
}

#Preview {
    RootView()
}
