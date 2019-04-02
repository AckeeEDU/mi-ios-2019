//
//  AppFlowCoordinator.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 02/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class AppFlowCoordinator: BaseFlowCoordinator {
    
    weak var navigationController: UINavigationController!
    
    func start(in window: UIWindow) {
        
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.navigationController = navigationController
        
        AppDependency.shared.userRepository.currentUser.producer
            .skipRepeats { $0?.username == $1?.username }
            .startWithValues { [weak navigationController] user in
                
                if let _ = user {
                    let logoutVM = LogoutViewModel(dependencies: AppDependency.shared)
                    let vc = LogoutViewController(viewModel: logoutVM)
                    vc.flowDelegate = self
                    navigationController?.setViewControllers([vc], animated: true)
                } else {
                    let loginVM = LoginViewModel(dependencies: AppDependency.shared)
                    let vc = LoginViewController(viewModel: loginVM)
                    vc.flowDelegate = self
                    navigationController?.setViewControllers([vc], animated: true)
                }
            }
    }
    
}

extension AppFlowCoordinator: LogoutFlowDelegate {
    func changePasswordTapped(in viewController: LogoutViewController) {
        let vm = PasswordEditViewModel(dependencies: AppDependency.shared)
        let vc = PasswordEditViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppFlowCoordinator: LoginFlowDelegate {
    func registerTapped(in viewController: LoginViewController) {
        let viewModel = RegistrationViewModel(dependencies: AppDependency.shared)
        let controller = RegistrationViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        
        viewController.present(navigationController, animated: true)
    }
}
