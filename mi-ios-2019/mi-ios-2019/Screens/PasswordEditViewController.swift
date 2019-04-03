//
//  PasswordEditViewController.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 18/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol PasswordEditFlowDelegate: class {
    func doneTapped(in viewController: PasswordEditViewController)
}

final class PasswordEditViewController: BaseViewController, ValidationErrorPresentable {

    private weak var passwordTextField: UITextField!
    private weak var passwordCheckTextField: UITextField!

    weak var flowDelegate: PasswordEditFlowDelegate?
    private let viewModel: PasswordEditViewModeling

    // MARK: - Initialization

    init(viewModel: PasswordEditViewModeling) {
        self.viewModel = viewModel

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        setupBindings()
    }

    // MARK: - Actions

    @objc
    private func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)

        viewModel.doneAction.apply().start()
    }

    // MARK: - Bindings

    private func setupBindings() {
        passwordTextField <~> viewModel.password
        passwordCheckTextField <~> viewModel.passwordCheck

        viewModel.doneAction.errors
            .observe(on: UIScheduler())
            .observeValues { [weak self] error in
                self?.displayValidationError(error)
            }

        viewModel.doneAction.completed
            .observe(on: UIScheduler())
            .observeValues { [weak self] in
                self?.flowDelegate?.doneTapped(in: self!)
            }
    }

    // MARK: - Helpers

    private func createPasswordTextField() -> UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = true

        return textField
    }

}
