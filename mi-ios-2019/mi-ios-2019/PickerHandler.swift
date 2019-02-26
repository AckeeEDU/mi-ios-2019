//
//  PickerHandler.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

protocol PickerHandler { }

extension PickerHandler {
    func requiresConfirmation<Item: Pickable & AlmostEquatable>(old: Item?, new: Item) -> Bool {
        if let old = old, old ~!= new {
            return true
        }
        return false
    }
}

extension PickerHandler where Self: UIViewController {
    func confirmChangeIfNeeded<Item: Pickable & AlmostEquatable>(old: Item?, new: Item, confirmAction: @escaping () -> ()) {
        if requiresConfirmation(old: old, new: new) {
            let confirmVC = confirmChangeAlert(confirmAction)
            present(confirmVC, animated: true)
        } else {
            confirmAction()
        }
    }
    
    func confirmChangeAlert(_ confirmAction: @escaping () -> ()) -> UIAlertController {
        let confirmVC = UIAlertController(title: "Confirm change", message: "Do you want to perform change?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in confirmAction() }
        let no = UIAlertAction(title: "No", style: .cancel)
        confirmVC.addAction(yes)
        confirmVC.addAction(no)
        return confirmVC
    }
}
