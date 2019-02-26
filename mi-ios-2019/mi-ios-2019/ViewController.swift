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
    @IBOutlet weak var pickAnimalButton: UIButton!
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
    
    // MARK: - UI actions
    
    @IBAction func pickCarButtonTapped(_ sender: Any) {
        let pickerVC = PickerViewController<CarKind>()
        pickerVC.resultHandler = { [weak self] sender, result in
            sender.dismiss(animated: true)
            self?.handleCarKindPicked(result)
        }
        showDetailViewController(pickerVC, sender: sender)
    }
    
    @IBAction func pickAnimalButtonTapped(_ sender: Any) {
        let pickerVC = PickerViewController<Animal>()
        pickerVC.resultHandler = { [weak self] sender, result in
            sender.dismiss(animated: true)
            self?.handleAnimalPicked(result)
        }
        showDetailViewController(pickerVC, sender: sender)
    }
    
    // MARK: - Private helpers
    
    private var lastCarKind: CarKind?
    
    private func handleCarKindPicked(_ result: CarKind?) {
        guard let result = result else { return }
        
        if let last = lastCarKind, last ~!= result {
            let confirmVC = confirmChangeAlert { [weak self] in self?.performCarKindChange(result)
            }
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
    
    private var lastAnimal: Animal?
    
    private func handleAnimalPicked(_ result: Animal?) {
        guard let result = result else { return }
        
        if let last = lastAnimal, last ~!= result {
            let confirmVC = confirmChangeAlert { [weak self] in self?.performAnimalChange(result)
            }
            present(confirmVC, animated: true)
        } else {
            performAnimalChange(result)
        }
    }
    
    private func performAnimalChange(_ animal: Animal) {
        lastAnimal = animal
        
        let alertVC = UIAlertController(title: "Animal Picked", message: animal.title + " " + animal.subtitle, preferredStyle: .alert)
        alertVC.addAction(.ok)
        present(alertVC, animated: true)
    }
    
    private func confirmChangeAlert(confirmAction: @escaping () -> ()) -> UIAlertController {
        let confirmVC = UIAlertController(title: "Confirm change", message: "Do you want to perform change?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in confirmAction() }
        let no = UIAlertAction(title: "No", style: .cancel)
        confirmVC.addAction(yes)
        confirmVC.addAction(no)
        return confirmVC
    }
}

