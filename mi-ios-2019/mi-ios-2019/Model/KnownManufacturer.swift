//
//  KnownManufacturer.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

enum KnownPersonalManufacturer: String, CaseIterable {
    case audi = "Audi"
    case bmw = "BMW"
    case ferrari = "Ferrari"
    case mercedes = "Mercedes"
    case porsche = "Porsche"
    case skoda = "Škoda"
}

enum KnownLorryManufacturer: String, CaseIterable {
    case tatra = "Tatra"
}

enum KnownMotorbikeManufacturer: String, CaseIterable {
    case ducati = "Ducati"
    case honda = "Honda"
    case suzuki = "Suzuki"
    case yamaha = "Yamaha"
}
