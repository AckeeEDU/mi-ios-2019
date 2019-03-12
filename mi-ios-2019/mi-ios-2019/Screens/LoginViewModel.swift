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
    case validation
    case invalidCredentials
    case network
}

class LoginViewModel {
    
    
    lazy var loginAction = Action<(),User,LoginError> {
        return .empty
    }
    
    
    let userName  = MutableProperty<String>("")
    let password  = MutableProperty<String>("")
    
    
    var validationSignal : Signal<Bool,NoError>
    
    lazy var canSubmitForm : Property<Bool> = Property<Bool>(initial: false, then: validationSignal.and(loginAction.isExecuting.signal.negate()))
    //lazy var canSubmitForm : Property<Bool> = Property<Bool>(initial: false, then: validationSignal.map { return $0 && !self.loginAction.isExecuting.value})

    
    init() {
        validationSignal = userName.combineLatest(with: password).signal.map { userName, password in
            (!userName.isEmpty && !password.isEmpty)
        }
        
        
    }
    
    
    
}
