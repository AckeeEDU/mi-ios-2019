//
//  RegistrationViewModel.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 14/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import ReactiveSwift

final class RegistrationViewModel {
    let name: MutableProperty<String>
    let phone: MutableProperty<String>
    let email: MutableProperty<String>

    let validate: Action<Void, Void, ValidationError>

    // MARK: - Initialization

    init() {
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
                }

                if email.isEmpty {
                    observer.send(error: ValidationError(message: "E-mail is empty"))
                }

                observer.send(value: ())
                observer.sendCompleted()
            }
        }
    }
}
