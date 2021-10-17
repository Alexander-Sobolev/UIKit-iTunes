//
//  UserDefaults.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 17.10.2021.
//

import Foundation

class UserDefaultsData {
    
    static let shared = UserDefaultsData()
    
    let defaults = UserDefaults.standard

    var users: [User] {
        get {
            if let data = defaults.value(forKey: "user") as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "user")
            }
        }
    }
    
    func saveUser(firstName: String, seconName: String, phone: String, email: String, password: String, age: Date) {
        
        let user = User(firstName: firstName, secondName: seconName, phone: phone, email: email, password: password, age: age)
        users.insert(user, at: 0)
    }
}
