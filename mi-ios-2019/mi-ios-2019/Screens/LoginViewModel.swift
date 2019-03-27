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

protocol LoginViewModeling {
    var userName: MutableProperty<String> { get }
    var password: MutableProperty<String> { get }

    var loginAction: Action<Void, User, LoginError> { get }

    func clearData()
}

final class LoginViewModel: BaseViewModel, LoginViewModeling {
    typealias Dependencies = HasUserRepository

    let userName = MutableProperty<String>("")
    let password = MutableProperty<String>("")

    lazy var loginAction = Action<Void, User, LoginError> { [unowned self] in
        if self.validationSignal.value {
            return self.dependencies.userRepository.login(username: self.userName.value, password: self.password.value)
        } else {
            return SignalProducer<User, LoginError>(error: .validation(self.validationErrors.value))
        }
    }

    private var validationSignal: Property<Bool>
    var validationErrors: Property<[LoginValidation]>

    lazy var canSubmitForm: Property<Bool> = Property<Bool>(initial: false, then: validationSignal.producer.and(self.loginAction.isExecuting.negate()))

    private let dependencies: Dependencies

    // MARK: - Initialization

    init(dependencies: Dependencies) {
        self.dependencies = dependencies

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

    func clearData() {
        dependencies.userRepository.clearData()
    }

}
