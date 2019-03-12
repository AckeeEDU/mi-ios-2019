//
//  LoginViewModel.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result

enum LoginError : Error {
    case validation()
    case invalidCredentials
    case network
}

class LoginViewModel {
    
    
    lazy var loginAction = Action<(),User,LoginError> {
        if self.validationSignal.value {
            return .empty
        } else {
            return SignalProducer<User,LoginError>(error: .validation)
        }
    }
    
    
    let userName  = MutableProperty<String>("")
    let password  = MutableProperty<String>("")
    
    
    private var validationSignal : Property<Bool>
    
    lazy var canSubmitForm : Property<Bool> = Property<Bool>(initial: false, then: validationSignal.producer.and(self.loginAction.isExecuting.negate()))
    //lazy var canSubmitForm : Property<Bool> = Property<Bool>(initial: false, then: validationSignal.map { return $0 && !self.loginAction.isExecuting.value})

    
    init() {
        validationSignal = userName.combineLatest(with: password).map { userName, password in
            (!userName.isEmpty && !password.isEmpty)
        }
        
        
    }
    
    
    
}
