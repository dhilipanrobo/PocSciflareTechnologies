//
//  Validate Manager.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 09/06/24.
//

import Foundation
func validateEmail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return !emailTest.evaluate(with: email)
  }
func validatePhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegEx = "^[0-9]{10}$"
        let phoneNumberTest = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        return !phoneNumberTest.evaluate(with: phoneNumber)
    }
