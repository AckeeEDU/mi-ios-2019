//
//  AppFlowCoordinator.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 02/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class AppFlowCoordinator: BaseFlowCoordinator {
    
    let popupTransitionController = PopupTransitionController()
    
    public var childCoordinators = [BaseFlowCoordinator]()
    
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
    func animationsTapped(in viewController: LogoutViewController) {
        let vc = AnimationsViewController()
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = popupTransitionController
        
        viewController.present(vc, animated: true)
    }
    
    func changePasswordTapped(in viewController: LogoutViewController) {
        let vm = PasswordEditViewModel(dependencies: AppDependency.shared)
        let vc = PasswordEditViewController(viewModel: vm)
        vc.flowDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppFlowCoordinator: LoginFlowDelegate {
    func registerTapped(in viewController: LoginViewController) {
        let fc = RegisterFlowCoordinator()
        childCoordinators.append(fc)
        fc.start(from: viewController)
    }
}

extension AppFlowCoordinator: PasswordEditFlowDelegate {
    func doneTapped(in viewController: PasswordEditViewController) {
        navigationController.popViewController(animated: true)
    }
}
