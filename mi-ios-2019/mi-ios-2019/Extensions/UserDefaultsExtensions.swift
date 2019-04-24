//
//  UserDefaultsExtensions.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 24/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

extension UserDefaults {
    static var groupStandard: UserDefaults {
        let appGroupName = Bundle.main.infoDictionary?["AppGroup"] as? String
        return UserDefaults(suiteName: appGroupName)!
    }
}
