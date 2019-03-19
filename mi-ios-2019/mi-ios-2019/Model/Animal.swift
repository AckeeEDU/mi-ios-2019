//
//  Pet.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

struct Animal {
    enum Kind {
        case pet
        case wild

        var name: String {
            switch self {
            case .pet: return "Pet"
            case .wild: return "Wild"
            }
        }
    }

    let kind: Kind
    let name: String
}

extension Animal: Pickable {
    static var allCases: [Animal] {
        return [
            Animal(kind: .pet, name: "Dog"),
            Animal(kind: .pet, name: "Cat"),
            Animal(kind: .wild, name: "Lion"),
            Animal(kind: .wild, name: "Tiger"),
            Animal(kind: .wild, name: "Panther")
        ]
    }

    var title: String {
        return name
    }

    var subtitle: String {
        return kind.name
    }
}

extension Animal: AlmostEquatable {
    static func ~== (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.kind == rhs.kind
    }
}
