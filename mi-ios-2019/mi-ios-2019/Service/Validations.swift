//
//  Validations.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 14/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

struct ValidationError: Error {
    let message: String
}

protocol HasPhoneValidator {
    var phoneValidator: PhoneValidating { get }
}

protocol PhoneValidating {
    func validate(_ phone: String) -> Bool
}

class PhoneValidator: PhoneValidating {
    func validate(_ phone: String) -> Bool {
        return phone.hasPrefix("+420")
    }
}

protocol HasEmailValidator {
    var emailValidator: EmailValidating { get }
}

protocol EmailValidating {
    func validate(_ email: String) -> Bool
}

class EmailValidator: EmailValidating {
    func validate(_ email: String) -> Bool {
        return email.contains("@")
    }
}
