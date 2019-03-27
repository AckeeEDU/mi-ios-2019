//
//  LoginUITests.swift
//  mi-ios-2019-UITests
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testLoginSucceeded() {
        app.launch()

        // Test that on screen is login field
        let loginField = app.textFields["loginField"]
        XCTAssertTrue(loginField.exists)

        loginField.tap()
        loginField.typeText(User.test.username)

        let passwordField = app.textFields["passwordField"]
        XCTAssertTrue(passwordField.exists)

        passwordField.tap()
        passwordField.typeText(User.test.password)

        let loginButton = app.buttons["loginButton"]
        XCTAssertTrue(loginButton.exists)

        loginButton.tap()

        let logoutView = app.otherElements["logoutView"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: logoutView, handler: nil)
        waitForExpectations(timeout: 1, handler: nil)
    }

}
