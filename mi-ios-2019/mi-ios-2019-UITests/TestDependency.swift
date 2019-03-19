//
//  TestDependency.swift
//  mi-ios-2019-UITests
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

class TestDependency {
    private init() { }
    static let shared = TestDependency()

    lazy var userRepository: UserRepositoring = UserRepository()
}

extension TestDependency: HasUserRepository { }
