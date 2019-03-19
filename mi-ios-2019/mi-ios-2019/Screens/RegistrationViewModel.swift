//
//  RegistrationViewModel.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 14/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import ReactiveSwift

struct UserRegistrationData {
    let name: String
    let phone: String
    let email: String
}

final class RegistrationViewModel {
    typealias Dependencies = HasPasswordEditViewModelingFactory

    let name: MutableProperty<String>
    let phone: MutableProperty<String>
    let email: MutableProperty<String>

    var passwordViewModel: PasswordEditViewModeling {
        let userData = UserRegistrationData(name: name.value, phone: phone.value, email: email.value)
        return dependencies.passwordEditViewModelingFactory(userData)
    }

    let validate: Action<Void, Void, ValidationError>

    private let dependencies: Dependencies

    // MARK: - Initialization

    init(dependencies: Dependencies) {
        self.dependencies = dependencies

        name = MutableProperty("")
        phone = MutableProperty("")
        email = MutableProperty("")

        validate = Action(state: Property.combineLatest(name, phone, email)) { state, _ in
            let (name, phone, email) = state

            return SignalProducer { observer, _ in
                if name.isEmpty {
                    observer.send(error: ValidationError(message: "Name is empty"))
                }

                if phone.isEmpty {
                    observer.send(error: ValidationError(message: "Phone is empty"))
                } else if PhoneValidator.shared.validate(phone) == false {
                    observer.send(error: ValidationError(message: "Phone is not valid"))
                }

                if email.isEmpty {
                    observer.send(error: ValidationError(message: "E-mail is empty"))
                } else if EmailValidator.shared.validate(email) == false {
                    observer.send(error: ValidationError(message: "E-mail is not valid"))
                }

                observer.send(value: ())
                observer.sendCompleted()
            }
        }
    }
}
