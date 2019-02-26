//
//  CarKind.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

enum CarKind: CaseIterable {
    case personal
    case lorry
    case motorbike
    case other
    
    var title: String {
        switch self {
        case .personal: return "Personal"
        case .lorry: return "Lorry"
        case .motorbike: return "Motorbike"
        case .other: return "Other"
        }
    }
}
