//
//  POC_Sciflare_TechnologiesTests.swift
//  POC Sciflare TechnologiesTests
//
//  Created by Apple on 08/06/24.
//

import XCTest
@testable import POC_Sciflare_Technologies
import SwiftUI

final class POC_Sciflare_TechnologiesTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    func testvalidateEmail(){
        XCTAssertTrue(validateEmail(email: ""), "issue in validateEmail func")
        XCTAssertFalse(validateEmail(email: "dhilipan@gmail.com"), "issue in validateEmail func")
        
    }
    func testvalidatePhoneNumber(){
        XCTAssertTrue(validatePhoneNumber(phoneNumber: ""), "issue in validateEmail func")
        XCTAssertFalse(validatePhoneNumber(phoneNumber: "1234567890"), "issue in validateEmail func")
        
    }
    
    func testValidateUser(){
        let addUserController = AddUserController()
        var name = ""
        var email = ""
        var mobileNumber = ""
        var gender = ""
        
        XCTAssertFalse(addUserController.validateUser(name: name, email: email, mobileNumber: mobileNumber, gender: gender), "issue in validateUser func")
        
        name = "dhilipan"
        email = "dhilipan@gmail.com"
        mobileNumber = "1234567890"
        gender = "Male"
        
        XCTAssertTrue(addUserController.validateUser(name: name, email: email, mobileNumber: mobileNumber, gender: gender), "issue in validateUser func")
    }
    
    func testUserListEndPoint () async{
        let expectation = XCTestExpectation(description: "Fetch data from API")
        ApiManager.getData(api: "\(devUrl())") { response in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([userListBase].self, from: response)
                
                XCTAssertTrue((responseModel[0].name != nil),"Data not received from API")
                expectation.fulfill()
            }catch{
            }
        } failure: { Error in
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
