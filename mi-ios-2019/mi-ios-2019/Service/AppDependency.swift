//
//  AppDependency.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

protocol HasNoDependency { }

final class AppDependency: HasNoDependency {
    private init() { }
    static let shared = AppDependency()

    lazy var userRepository: UserRepositoring = UserRepository()
}

extension AppDependency: HasUserRepository { }
