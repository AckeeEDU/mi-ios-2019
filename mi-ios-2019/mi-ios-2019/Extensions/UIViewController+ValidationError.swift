//
//  UIViewController+ValidationError.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 18/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

protocol ValidationErrorPresentable {
    func present(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension ValidationErrorPresentable {
    func present(_ controller: UIViewController, animated: Bool) {
        present(controller, animated: animated, completion: nil)
    }
}

extension ValidationErrorPresentable {

    func displayValidationError(_ error: ValidationError) {
        let alertController = UIAlertController(title: "Error!", message: error.message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }

}
