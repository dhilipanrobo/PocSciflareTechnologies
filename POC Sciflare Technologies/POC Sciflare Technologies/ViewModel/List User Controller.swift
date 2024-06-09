//
//  List User Controller.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import Foundation
import CoreData

class ListUserController : ObservableObject {
    let coreDataManager = CoreDataManager()
    @Published var userEntity :[UserEntity] = [UserEntity]()
    func load()  {
        userEntity = coreDataManager.fetchUser()
    }
}
