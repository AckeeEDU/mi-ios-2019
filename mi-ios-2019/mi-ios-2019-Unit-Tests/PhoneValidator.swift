//
//  PhoneValidator.swift
//  mi-ios-2019-Unit-Tests
//
//  Created by Lukáš Hromadník on 19/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import XCTest

final class PhoneValidatorTests: XCTestCase {
    
    private let phoneValidator = PhoneValidator()
    
    func testPhoneIsValid() {
        let phone = "+420777000000"
        let isValid = phoneValidator.validate(phone)
        
        XCTAssertTrue(isValid)
    }

    func testPhoneIsNotValid() {
        let phone = "777000000"
        let isValid = phoneValidator.validate(phone)
        
        XCTAssertFalse(isValid)
    }

}
