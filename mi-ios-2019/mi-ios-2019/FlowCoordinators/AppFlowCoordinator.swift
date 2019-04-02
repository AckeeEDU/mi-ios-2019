//
//  AppFlowCoordinator.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 02/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class AppFlowCoordinator: BaseFlowCoordinator {
    
    func start(in window: UIWindow) {
        let userRepository = AppDependency.shared.userRepository
        
        userRepository.currentUser.producer
            .skipRepeats { $0?.username == $1?.username }
            .startWithValues { user in
                
                var vc: UIViewController!
                if let _ = user {
                    let logoutVM = LogoutViewModel(dependencies: AppDependency.shared)
                    let logoutVC = LogoutViewController(viewModel: logoutVM)
                    vc = UINavigationController(rootViewController: logoutVC)
                } else {
                    let loginVM = LoginViewModel(dependencies: AppDependency.shared)
                    let loginVC = LoginViewController(viewModel: loginVM)
                    vc = UINavigationController(rootViewController: loginVC)
                }
                window.rootViewController = vc
            }
    }
    
}
