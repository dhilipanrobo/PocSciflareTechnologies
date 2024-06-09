//
//  User list model.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import Foundation

import Foundation
struct userListBase : Codable,Hashable {
    let _id : String?
    let name : String?
    let mobile : String?
    let gender : String?
    let email : String?
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        case mobile = "mobile"
        case gender = "gender"
        case email = "email"
    }
}
