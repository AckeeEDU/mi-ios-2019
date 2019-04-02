//
//  RegisterFlowCoordinator.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 02/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit


class RegisterFlowCoordinator: BaseFlowCoordinator {
    
    weak var navigationController: UINavigationController!
    
    func start(from viewController: UIViewController) {
        
        let vm = RegistrationViewModel(dependencies: AppDependency.shared)
        let vc = RegistrationViewController(viewModel: vm)
        vc.flowDelegate = self
        
        let navigationController = UINavigationController(rootViewController: vc)
        viewController.present(navigationController, animated: true)
        self.navigationController = navigationController
    }
    
}

extension RegisterFlowCoordinator: RegistrationFlowDelegate {
    func registrationSuccessful(with userData: UserRegistrationData, in viewController: RegistrationViewController) {
        let vm = RegisterPasswordEditViewModel(dependencies: AppDependency.shared, userData: userData)
        let vc = PasswordEditViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
