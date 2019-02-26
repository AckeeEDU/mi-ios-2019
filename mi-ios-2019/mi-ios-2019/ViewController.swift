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
}

