//
//  TextFieldValidation.swift
//  OgreSpace
//
//  Created by admin on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet as CharacterSet) == nil
    }
}
extension UIViewController {
    
    
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func isValidUserName(username:String) -> Bool {
        let userNameRegEx = "^[0-9a-zA-Z\\_]{3,64}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", userNameRegEx)
        return emailTest.evaluate(with: username)
    }
    func isValidPassword(password:String) -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()~])(?=.*\\d)[a-zA-Z\\d\\W]{8,}$"
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: password)
    }
    func isValidName(name:String) -> Bool{
        let nameRegex = "^[a-zA-Z]{2,64}$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: name)
    }
    
    
    
    
    func validTextFieldData(textField:UITextField){
        DispatchQueue.main.async {
            textField.resignFirstResponder()
            textField.next?.becomeFirstResponder()
        }
    }
    func unValidTextFieldData(textField:UITextField){
        DispatchQueue.main.async {
            textField.becomeFirstResponder()
        }
    }
}

