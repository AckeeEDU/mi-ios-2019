//
//  CarKind.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation

enum CarKind: CaseIterable, CustomStringConvertible {
    case personal(KnownPersonalManufacturer)
    case lorry(KnownLorryManufacturer)
    case motorbike(KnownMotorbikeManufacturer)
    case other
    
    var title: String {
        switch self {
        case .personal(let manufacturer): return manufacturer.rawValue
        case .lorry(let manufacturer): return manufacturer.rawValue
        case .motorbike(let manufacturer): return manufacturer.rawValue
        case .other: return "Other"
        }
    }
    
    var subtitle: String {
        switch self {
        case .personal: return "Personal"
        case .lorry: return "Lorry"
        case .motorbike: return "Motorbike"
        case .other: return ""
        }
    }
    
    var description: String {
        return title + " (" + subtitle + ")"
    }
    
    static var allCases: [CarKind] {
        let personal = KnownPersonalManufacturer.allCases.map { CarKind.personal($0) }
        let lorries = KnownLorryManufacturer.allCases.map { CarKind.lorry($0) }
        let motorbikes = KnownMotorbikeManufacturer.allCases.map { CarKind.motorbike($0) }
        return personal + lorries + motorbikes + [.other]
    }
}
