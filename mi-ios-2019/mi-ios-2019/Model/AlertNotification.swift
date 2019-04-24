//
//  AlertNotification.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 24/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

struct AlertNotification: Codable {
    let alertTitle: String
    let alertMessage: String
    let buttonText: String
}
