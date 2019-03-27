//
//  LoginError.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case validation([LoginValidation])
    case invalidCredentials
    case network
}

enum LoginValidation {
    case username
    case password
}
