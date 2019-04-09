//
//  LogoutViewController.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol LogoutFlowDelegate: class {
    func changePasswordTapped(in viewController: LogoutViewController)
    func animationsTapped(in viewController: LogoutViewController)
}

final class LogoutViewController: BaseViewController {
    
    private weak var nameLabel: UILabel!
    private weak var usernameLabel: UILabel!
    private weak var phoneLabel: UILabel!
    private weak var passwordLabel: UILabel!
    private weak var logoutButton: UIButton!
    private weak var changePasswordButton: UIButton!
    private weak var animationsButton: UIButton!
    
    weak var flowDelegate: LogoutFlowDelegate?
    private let viewModel: LogoutViewModeling

    // MARK: - Initialization

    init(viewModel: LogoutViewModeling) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        super.loadView()

        view.backgroundColor = .gray
        view.accessibilityIdentifier = "logoutView"

        let nameLabel = UILabel()
        self.nameLabel = nameLabel

        let usernameLabel = UILabel()
        self.usernameLabel = usernameLabel

        let phoneLabel = UILabel()
        self.phoneLabel = phoneLabel

        let passwordLabel = UILabel()
        self.passwordLabel = passwordLabel

        let changePasswordButton = UIButton(type: .custom)
        changePasswordButton.setTitle("Change password", for: .normal)
        self.changePasswordButton = changePasswordButton
        
        let animationsButton = UIButton(type: .custom)
        animationsButton.setTitle("Go to animations", for: .normal)
        self.animationsButton = animationsButton
        
        let logoutButton = UIButton(type: .custom)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.red, for: .disabled)
        self.logoutButton = logoutButton

        // ----- Stack View -----
        let stackView = UIStackView(arrangedSubviews: [nameLabel, usernameLabel, phoneLabel, passwordLabel, animationsButton, changePasswordButton, logoutButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.leading.trailing.equalToSuperview().inset(48)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped(_:)), for: .touchUpInside)
        animationsButton.addTarget(self, action: #selector(animationsButtonTapped(_:)), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)

        setupBindings()
    }

    // MARK: - Actions

    @objc private func changePasswordButtonTapped(_ sender: UIButton) {
        flowDelegate?.changePasswordTapped(in: self)
    }
    
    @objc private func animationsButtonTapped(_ sender: UIButton) {
        flowDelegate?.animationsTapped(in: self)
    }
    
    @objc
    private func logoutButtonTapped(_ sender: UIButton) {
        viewModel.logout()
    }

    // MARK: - Bindings

    private func setupBindings() {
        nameLabel.reactive.text <~ viewModel.name
        usernameLabel.reactive.text <~ viewModel.username
        phoneLabel.reactive.text <~ viewModel.phone
        passwordLabel.reactive.text <~ viewModel.password
    }

}
