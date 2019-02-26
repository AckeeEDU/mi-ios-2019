//
//  ViewController.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 19/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var pickCarButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildNumberLabel: UILabel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Localize when permission is granted
        // navigationItem.title = L10n.Start.title
        // pickCarButton.setTitle(L10n.Start.pickCar, for: .normal)
        
        let versionText = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? ""
        let buildNumberText = (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? ""
        
        versionLabel.text = "\(L10n.Start.appVersion): \(versionText)"
        buildNumberLabel.text = "\(L10n.Start.buildNumber): \(buildNumberText)"
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "CarPickerSegue" where segue.destination is CarPickerViewController:
            let carPicker = segue.destination as! CarPickerViewController
            carPicker.resultHandler = { [weak self] sender, result in
                self?.handleCarPicked(from: sender, result: result)
            }
        default:
            assertionFailure("Uknown segue \(segue)")
        }
    }
    
    // MARK: - Private helpers
    
    private var lastCarKind: CarKind?
    
    private func handleCarPicked(from carPicker: CarPickerViewController, result: CarKind?) {
        carPicker.dismiss(animated: true)
        
        guard let result = result else { return }
        
        if let last = lastCarKind, last ~!= result {
            let confirmVC = UIAlertController(title: "Car kind change", message: "Do you want to perform change?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                self?.performCarKindChange(result)
            }
            let no = UIAlertAction(title: "No", style: .cancel)
            confirmVC.addAction(yes)
            confirmVC.addAction(no)
            present(confirmVC, animated: true)
        } else {
            performCarKindChange(result)
        }
    }
    
    private func performCarKindChange(_ carKind: CarKind) {
        lastCarKind = carKind
        
        let alertVC = UIAlertController(title: "Car Picker Result", message: carKind.description, preferredStyle: .alert)
        alertVC.addAction(.ok)
        present(alertVC, animated: true)
    }
}

