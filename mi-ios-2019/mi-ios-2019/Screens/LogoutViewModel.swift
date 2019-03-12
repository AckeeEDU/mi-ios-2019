//
//  LogoutViewModel.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import ReactiveSwift
import ACKReactiveExtensions



class LogoutViewModel : BaseViewModel {

    private var userRepository: UserRepository
    
    var userName = MutableProperty<String>("")
    var accessToken = MutableProperty<String>("")

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        
        super.init()
        
        
        userRepository.currentUser.producer.skipNil().startWithValues { (user) in
            self.userName.value = user.username
        }
        accessToken <~ userRepository.currentUser.producer.skipNil().map { $0.accessToken}

    }
    
    func logout() {
        userRepository.logouut()
    }
}

