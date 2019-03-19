//
//  PasswordEditViewController.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 18/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit
import ReactiveSwift

final class PasswordEditViewController: BaseViewController {

    private weak var passwordTextField: UITextField!
    private weak var passwordCheckTextField: UITextField!

    // MARK: - Controller lifecycle

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let passwordTextField = createPasswordTextField()
        passwordTextField.placeholder = "Password"
        self.passwordTextField = passwordTextField

        let passwordCheckTextField = createPasswordTextField()
        passwordCheckTextField.placeholder = "Password check"
        self.passwordCheckTextField = passwordCheckTextField

        let contentView = UIStackView(arrangedSubviews: [passwordTextField, passwordCheckTextField, UIView()])
        contentView.axis = .vertical
        contentView.spacing = 16
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Password"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
    }

    // MARK: - Actions

    @objc
    private func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)

        dismiss(animated: true)
    }

    // MARK: - Helpers

    private func createPasswordTextField() -> UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = true

        return textField
    }

}
