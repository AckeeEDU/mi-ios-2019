//
//  AppDependency+Factories.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

extension AppDependency: HasPasswordEditViewModelingFactory {
    var passwordEditViewModelingFactory: PasswordEditViewModelingFactory {
        return { userData in
            return RegisterPasswordEditViewModel(dependencies: self, userData: userData)
        }
    }
}
