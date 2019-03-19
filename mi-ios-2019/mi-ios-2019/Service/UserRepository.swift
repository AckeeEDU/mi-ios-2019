//
//  UserRepository.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import ReactiveSwift

final class UserRepository {
    private init() { }
    static let shared = UserRepository()

    lazy var currentUser = MutableProperty<User?>(self.retrieveUser())

    func login(username: String, password: String) -> SignalProducer<User, LoginError> {
        guard let user = retrieveUser(), user.password == password else {
            return SignalProducer(error: .invalidCredentials)
        }

        currentUser.value = user

        return SignalProducer(value: user)
    }

    func logout() {
        currentUser.value = nil
    }

    func clearData() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }

    private func retrieveUser() -> User? {
        if let data = UserDefaults.standard.value(forKey: "currentUser") as? Data,
            let user = try? PropertyListDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }

    func register(_ user: User) {
        let encodedUser = try? PropertyListEncoder().encode(user)
        UserDefaults.standard.set(encodedUser, forKey: "currentUser")
    }

}
