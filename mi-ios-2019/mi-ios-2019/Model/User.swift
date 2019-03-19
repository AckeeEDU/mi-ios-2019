//
//  User.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

struct User: Codable {
    var username: String
    var name: String
    var password: String
    var phone: String
}

extension User {
    static let test = User(username: "unicorn@ackee.cz", name: "Unicorn", password: "heslo", phone: "+420123456789")
}
