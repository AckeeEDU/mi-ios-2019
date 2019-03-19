//
//  EmailValidatorTests.swift
//  mi-ios-2019-Unit-Tests
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import XCTest

final class EmailValidatorTests: XCTestCase {

    private let emailValidator = EmailValidator()

    func testEmailIsValid() {
        let email = "unicorn@ackee.cz"

        let isValid = emailValidator.validate(email)

        XCTAssertTrue(isValid)
    }

    func testEmailIsNotValid() {
        let email = "unicorn"

        let isValid = emailValidator.validate(email)

        XCTAssertFalse(isValid)
    }

}
