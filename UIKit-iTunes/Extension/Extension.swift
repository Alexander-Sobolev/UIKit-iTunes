//
//  Extension.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 16.10.2021.
//

import Foundation

extension String {
    
    enum ValidType {
        case name
        case email
        case phone
        case password
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-zA-Z0-9_.-]+@[a-z.]+\\.[a-z]{2,10}"
        case phone =  "(?=.*[0-9])(?=.*[_()-+]).{18,}"
        case password = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"
    }
    
    func isValid(_ validType: ValidType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .phone:
            regex = Regex.phone.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
