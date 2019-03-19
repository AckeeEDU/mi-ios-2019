//
//  File.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift

final class LoginViewController: BaseViewController {

    private weak var usernameField: UITextField!
    private weak var passwordField: UITextField!
    private weak var loginButton: UIButton!
    private weak var registrationButton: UIButton!

    private let viewModel: LoginViewModel

    // MARK: - Initialization

    init(viewModel: LoginViewModel) {
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

        let usernameField = UITextField()
        usernameField.backgroundColor = .white
        usernameField.placeholder = "Username"
        view.addSubview(usernameField)
        usernameField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(35)
            make.leading.trailing.equalToSuperview().inset(48)
        }
        self.usernameField = usernameField

        let passwordField = UITextField()
        view.addSubview(passwordField)
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = .white
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameField.snp.bottom).offset(30)
            make.height.equalTo(usernameField)
            make.leading.trailing.equalTo(usernameField)
        }
        self.passwordField = passwordField

        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.red, for: .disabled)
        button.tintColor = .blue
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        self.loginButton = button

        let registrationButton = UIButton(type: .system)
        registrationButton.setTitle("Register", for: .normal)
        registrationButton.setTitleColor(.white, for: .normal)
        view.addSubview(registrationButton)
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        self.registrationButton = registrationButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()

        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped(_:)), for: .touchUpInside)
    }

    // MARK: - Bindings

    private func setupBindings() {
        passwordField <~> viewModel.password
        usernameField <~> viewModel.userName
        loginButton.reactive.isEnabled <~ viewModel.loginAction.isExecuting.negate()

        viewModel.loginAction.errors.producer.startWithValues { (errors) in
            print(errors)
        }
    }

    // MARK: - Actions

    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        viewModel.loginAction.apply().start()
    }

    @objc
    private func registrationButtonTapped(_ sender: UIButton) {
        let controller = RegistrationViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true)
    }

}
