//
//  PasswordEditViewModel.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 18/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import ReactiveSwift

typealias PasswordEditViewModelingFactory = (UserRegistrationData) -> PasswordEditViewModeling

protocol HasPasswordEditViewModelingFactory {
    var passwordEditViewModelingFactory: PasswordEditViewModelingFactory { get }
}

protocol PasswordEditViewModeling {
    var password: MutableProperty<String> { get }
    var passwordCheck: MutableProperty<String> { get }

    var doneAction: Action<Void, Void, ValidationError> { get }
}

final class RegisterPasswordEditViewModel: PasswordEditViewModeling {
    typealias Dependencies = HasUserRepository
    
    let password: MutableProperty<String>
    let passwordCheck: MutableProperty<String>
    
    let doneAction: Action<Void, Void, ValidationError>
    
    // MARK: - Initialization
    
    init(dependencies: Dependencies, userData: UserRegistrationData) {
        password = MutableProperty("")
        passwordCheck = MutableProperty("")
        
        doneAction = Action(state: Property.combineLatest(password, passwordCheck)) { state in
            let (password, passwordCheck) = state
            
            return SignalProducer { observer, _ in
                if password.isEmpty || passwordCheck.isEmpty {
                    observer.send(error: ValidationError(message: "Password is empty"))
                }
                
                if password != passwordCheck {
                    observer.send(error: ValidationError(message: "Passwords are not matching"))
                }
                
                let user = User(username: userData.email, name: userData.name, password: password, phone: userData.phone)
                dependencies.userRepository.register(user)
                
                observer.send(value: ())
                observer.sendCompleted()
            }
        }
    }
    
}

final class PasswordEditViewModel: PasswordEditViewModeling {
    typealias Dependencies = HasUserRepository

    let password: MutableProperty<String>
    let passwordCheck: MutableProperty<String>

    let doneAction: Action<Void, Void, ValidationError>

    // MARK: - Initialization

    init(dependencies: Dependencies) {
        password = MutableProperty("")
        passwordCheck = MutableProperty("")

        doneAction = Action(state: Property.combineLatest(password, passwordCheck)) { state in
            let (password, passwordCheck) = state

            return SignalProducer { observer, _ in
                if password.isEmpty || passwordCheck.isEmpty {
                    observer.send(error: ValidationError(message: "Password is empty"))
                }

                if password != passwordCheck {
                    observer.send(error: ValidationError(message: "Passwords are not matching"))
                }

                dependencies.userRepository.changePassword(password)

                observer.send(value: ())
                observer.sendCompleted()
            }
        }
    }

}
