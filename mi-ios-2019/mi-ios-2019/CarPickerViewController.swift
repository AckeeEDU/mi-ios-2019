//
//  CarPickerViewController.swift
//  mi-ios-2019
//
//  Created by Jakub Olejník on 26/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

final class CarPickerViewController: UIViewController {
    typealias ResultHandler = (CarPickerViewController) -> ()
    
    var resultHandler: ResultHandler?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Localize when permission is granted
        // closeButton.setTitle(L10n.CarPicker.close, for: .normal)
        // titleLabel.text = L10n.CarPicker.title
    }
    
    // MARK: - UI actions
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        resultHandler?(self)
    }
}

extension CarPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}

extension CarPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultHandler?(self)
    }
}
