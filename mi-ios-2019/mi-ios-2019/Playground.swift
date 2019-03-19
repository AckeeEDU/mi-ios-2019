//
//  Playground.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

enum Playground {
    static func play() {
        let arrayOfAlmostEquatables = Animal.allCases
        let arrayOfAlmostEquatables2 = Animal.allCases
        let arrayOfAlmostEquatables3 = Array(Animal.allCases.prefix(1))

        print(arrayOfAlmostEquatables ~== arrayOfAlmostEquatables2)
        print(arrayOfAlmostEquatables ~== arrayOfAlmostEquatables3)

//        let someStruct = SomeStruct(item: arrayOfAlmostEquatables)
    }
}

private struct SomeStruct<Item: AlmostEquatable> {
    let item: Item
}

extension Array where Element: AlmostEquatable {
    static func~==(lhs: [Element], rhs: [Element]) -> Bool {
        guard lhs.count == rhs.count else { return false }

        for i in 0..<lhs.count {
            if lhs[i] ~!= rhs[i] { return false }
        }

        return true
    }
}

//extension Array: AlmostEquatable where Element: AlmostEquatable {
//}
