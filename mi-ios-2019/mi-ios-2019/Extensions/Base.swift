//
//  Base.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        NSLog("📱 👶 \(self)")
    }
    
    deinit {
        NSLog("📱 ⚰️ \(self)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BaseViewModel {
    
    init() {
        NSLog("🧠 👶 \(self)")
        
    }
    
    deinit {
        NSLog("🧠 ⚰️ \(self)")
    }
}
