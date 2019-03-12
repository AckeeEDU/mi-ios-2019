//
//  UserRepository.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import ReactiveSwift


class UserRepository {
    
    lazy var currentUser = MutableProperty<User?>(self.retrieveUser())
    
    func login(username: String, password: String) -> SignalProducer<User,LoginError> {
        if Int.random(in: 0...10) < 2 {
            return SignalProducer(error: .network)
        }
        if username == "Bb" {
            return SignalProducer(error: .invalidCredentials)
        }
        
        
        let user = User(username: username, accessToken: "aabcd")
        currentUser.value = user
        UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey:"currentUser")
        UserDefaults.standard.synchronize()
        return SignalProducer(value: user )
    }
    
    func logouut() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
        UserDefaults.standard.synchronize()
        currentUser.value = nil
    }
    
    func retrieveUser() -> User? {
        if let data = UserDefaults.standard.value(forKey:"currentUser") as? Data,
            let user = try? PropertyListDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }
    
    
    
}
