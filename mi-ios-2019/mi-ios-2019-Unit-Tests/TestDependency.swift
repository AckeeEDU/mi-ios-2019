//
//  TestDependency.swift
//  mi-ios-2019-Unit-Tests
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

class TestDependency {
    private init() { }
    static let shared = TestDependency()

    lazy var userRepository: UserRepositoring = UserRepository()
    lazy var phoneValidator: PhoneValidating = PhoneValidator()
    lazy var emailValidator: EmailValidating = EmailValidator()
}

extension TestDependency: HasUserRepository { }
extension TestDependency: HasPhoneValidator { }
extension TestDependency: HasEmailValidator { }

extension TestDependency: HasPasswordEditViewModelingFactory {
    var passwordEditViewModelingFactory: PasswordEditViewModelingFactory {
        return { userData in
            return PasswordEditViewModel(dependencies: self, userData: userData)
        }
    }
}
