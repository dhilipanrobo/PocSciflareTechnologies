//
//  CoreDataManager.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//


import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let presistentContainert : NSPersistentContainer
    init() {
        presistentContainert = NSPersistentContainer(name: "POC_Sciflare_Technologies")
        presistentContainert.loadPersistentStores { (description, error) in
            
            if let error = error {
                fatalError("Core data store failed to init\(error.localizedDescription)")
            }
        }
        
    }
    
    //MARK: -Save Data
    
    func saveUser(name:String,email:String,mobileNumber:String,gender:String,id:String) {
        let user = UserEntity(context: presistentContainert.viewContext)
        user.name = name
        user.id = id
        user.email = email
        user.mobile = mobileNumber
        user.gender = gender
        do{
            try presistentContainert.viewContext.save()
            print("Data saved! ")
        }catch{
            print("Save data get error \(error)")
        }
    }
    
    //MARK: - Fetch Data
    
    func fetchUser() -> [UserEntity] {
        let fetchRequest:NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            return try presistentContainert.viewContext.fetch(fetchRequest)
        }catch{return []}
    }
    //MARK: - Update Data
    func updateUser() {
       
        do{
            try presistentContainert.viewContext.save()
            print("Data saved! ")
        }catch{
            presistentContainert.viewContext.rollback()
          print("Save data get error \(error)")
        }
    }
    //MARK: - Delete Data
    
    func deleteUser(userEntity:UserEntity) {
        presistentContainert.viewContext.delete(userEntity)
        do{
            try presistentContainert.viewContext.save()
        }catch{
             presistentContainert.viewContext.rollback()
            print ("fail to delete \(error.localizedDescription)")
        }
    }
}
    

