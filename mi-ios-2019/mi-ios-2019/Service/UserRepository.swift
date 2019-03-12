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
    
    var currentUser = MutableProperty<User?>(nil)
    
    func login(username: String, password: String) -> SignalProducer<User,LoginError> {
        if Int.random(in: 0...10) < 2 {
            return SignalProducer(error: .network)
        }
        if username == "Bb" {
            return SignalProducer(error: .invalidCredentials)
        }
        
        
        let user = User(username: username, accessToken: "aabcd")
        currentUser.value = user
        return SignalProducer(value: user )
    }
    
}
