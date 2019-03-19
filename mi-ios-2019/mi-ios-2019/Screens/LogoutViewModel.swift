//
//  LogoutViewModel.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import ReactiveSwift
import ACKReactiveExtensions

class UserInfoViewModel: BaseViewModel {

    let name = MutableProperty<String?>(nil)
    let username = MutableProperty<String?>(nil)
    let phone = MutableProperty<String?>(nil)
    let password = MutableProperty<String?>(nil)

    fileprivate let userRepository: UserRepository

    // MARK: - Initialization

    init(userRepository: UserRepository) {
        self.userRepository = userRepository

        super.init()

        setupBindings()
    }

    // MARK: - Bindings

    private func setupBindings() {
        let user = userRepository.currentUser

        name <~ user.map { $0?.name }
        username <~ user.map { $0?.username }
        phone <~ user.map { $0?.phone }
        password <~ user.map { $0?.password }
    }

}

final class LogoutViewModel: UserInfoViewModel {

    func logout() {
        userRepository.logout()
    }

}
