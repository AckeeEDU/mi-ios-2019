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

enum LoginError: Error {
    case validation([LoginValidation])
    case invalidCredentials
    case network
}

enum LoginValidation {
    case username
    case password
}

final class LoginViewModel: BaseViewModel {

    let userName = MutableProperty<String>("")
    let password = MutableProperty<String>("")

    lazy var loginAction = Action<Void, User, LoginError> { [unowned self] in
        if self.validationSignal.value {
            return self.userRepository.login(username: self.userName.value, password: self.password.value)
        } else {
            return SignalProducer<User, LoginError>(error: .validation(self.validationErrors.value))
        }
    }

    private var validationSignal: Property<Bool>
    var validationErrors: Property<[LoginValidation]>

    lazy var canSubmitForm: Property<Bool> = Property<Bool>(initial: false, then: validationSignal.producer.and(self.loginAction.isExecuting.negate()))

    private var userRepository: UserRepository

    // MARK: - Initialization

    init(userRepository: UserRepository) {
        self.userRepository = userRepository

        validationErrors = userName.combineLatest(with: password).map { userName, password in
            var validations: [LoginValidation]  = []
            if userName.isEmpty {
                validations.append(.username)
            }
            if password.isEmpty {
                validations.append(.password)
            }
            return validations
        }

        validationSignal = validationErrors.map { $0.isEmpty }
    }

}
