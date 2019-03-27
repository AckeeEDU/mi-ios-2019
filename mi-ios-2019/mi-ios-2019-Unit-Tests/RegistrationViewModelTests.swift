//
//  RegistrationViewModelTests.swift
//  mi-ios-2019-Unit-Tests
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import XCTest

final class RegistrationViewModelTests: XCTestCase {

    private let viewModel = RegistrationViewModel(dependencies: TestDependency.shared)

    override func setUp() {
        viewModel.name.value = "Jméno"
        viewModel.email.value = "unicorn@ackee.cz"
        viewModel.phone.value = "+420123456789"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidViewModelDataReturnsNoError() {
        let expectation = XCTestExpectation(description: "Valid viewModel data returns no error")

        viewModel.actions.validate.completed.observeValues {
            expectation.fulfill()
        }

        viewModel.actions.validate.apply().start()

        wait(for: [expectation], timeout: 1)
    }

    func testEmptyNameReturnsError() {
        viewModel.name.value = ""

        let expectation = XCTestExpectation(description: "Empty name returns error")

        viewModel.actions.validate.errors.observeValues { _ in
            expectation.fulfill()
        }

        viewModel.actions.validate.apply().start()

        wait(for: [expectation], timeout: 1)
    }

    func testEmptyEmailReturnsError() {
        viewModel.email.value = ""

        let expectation = XCTestExpectation(description: "Empty email returns error")

        viewModel.actions.validate.errors.observeValues { _ in
            expectation.fulfill()
        }

        viewModel.actions.validate.apply().start()

        wait(for: [expectation], timeout: 1)
    }

    func testInvalidEmailReturnsError() {
        viewModel.email.value = "invalidní mail"

        let expectation = XCTestExpectation(description: "Invalid name returns error")

        viewModel.actions.validate.errors.observeValues { _ in
            expectation.fulfill()
        }

        viewModel.actions.validate.apply().start()

        wait(for: [expectation], timeout: 1)
    }

    func testEmptyPhoneReturnsError() {
        viewModel.phone.value = ""

        let expectation = XCTestExpectation(description: "Empty phone returns error")

        viewModel.actions.validate.errors.observeValues { _ in
            expectation.fulfill()
        }

        viewModel.actions.validate.apply().start()

        wait(for: [expectation], timeout: 1)
    }

    func testInvalidPhoneReturnsError() {
        viewModel.phone.value = "123456789"

        let expectation = XCTestExpectation(description: "Invalid phone returns error")

        viewModel.actions.validate.errors.observeValues { _ in
            expectation.fulfill()
        }

        viewModel.actions.validate.apply().start()

        wait(for: [expectation], timeout: 1)
    }

}
