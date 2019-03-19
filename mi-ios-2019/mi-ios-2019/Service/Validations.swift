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

class PhoneValidator {
    private init() { }
    static let shared = PhoneValidator()

    func validate(_ phone: String) -> Bool {
        return phone.hasPrefix("+420")
    }
}
