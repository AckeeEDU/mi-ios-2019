//
//  LogoutViewModel.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import ReactiveSwift
import ACKReactiveExtensions
import enum Result.NoError

protocol UserInfoViewModeling {
    var name: MutableProperty<String?> { get }
    var username: MutableProperty<String?> { get }
    var phone: MutableProperty<String?> { get }
    var password: MutableProperty<String?> { get }
    var alertNotifications: Signal<AlertNotification, NoError> { get }
}

class UserInfoViewModel: BaseViewModel, UserInfoViewModeling {
    typealias Dependencies = HasUserRepository & HasPushManager

    let name = MutableProperty<String?>(nil)
    let username = MutableProperty<String?>(nil)
    let phone = MutableProperty<String?>(nil)
    let password = MutableProperty<String?>(nil)
    let alertNotifications: Signal<AlertNotification, NoError>

    fileprivate let dependencies: Dependencies

    // MARK: - Initialization

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        alertNotifications = dependencies.pushManager.notificationSignal

        super.init()

        setupBindings()
    }

    // MARK: - Bindings

    private func setupBindings() {
        let user = dependencies.userRepository.currentUser

        name <~ user.map { $0?.name }
        username <~ user.map { $0?.username }
        phone <~ user.map { $0?.phone }
        password <~ user.map { $0?.password }
    }

}

protocol LogoutViewModeling: UserInfoViewModeling {
    func logout()
}

final class LogoutViewModel: UserInfoViewModel, LogoutViewModeling {

    func logout() {
        dependencies.userRepository.logout()
    }

}
