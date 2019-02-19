//
//  ViewController.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 19/02/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        buildNumberLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }


}

