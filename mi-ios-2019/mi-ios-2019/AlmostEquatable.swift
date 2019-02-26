//
//  AlmostEquatable.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

precedencegroup AlmostEqualPrecedence {
    associativity: left
    higherThan: ComparisonPrecedence
}

infix operator ~==: AlmostEqualPrecedence

protocol AlmostEquatable {
    static func~==(lhs: Self, rhs: Self) -> Bool
}
