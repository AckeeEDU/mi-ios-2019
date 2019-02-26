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
    }
    
    let kind: Kind
    let name: String
}
