//
//  RegistrationViewController.swift
//  mi-ios-2019
//
//  Created by Lukáš Hromadník on 14/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit
import ReactiveSwift

final class RegistrationViewController: BaseViewController, ValidationErrorPresentable {

    private weak var nameTextField: UITextField!
    private weak var phoneTextField: UITextField!
    private weak var emailTextField: UITextField!

    private let viewModel: RegistrationViewModel

    // MARK: - Initialization

    init(viewModel: RegistrationViewModel) {
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

        let nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        self.nameTextField = nameTextField

        let phoneTextField = UITextField()
        phoneTextField.placeholder = "Phone"
        phoneTextField.keyboardType = .phonePad
        self.phoneTextField = phoneTextField

        let emailTextField = UITextField()
        emailTextField.placeholder = "E-mail"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.returnKeyType = .done
        self.emailTextField = emailTextField

        let contentView = UIStackView(arrangedSubviews: [nameTextField, phoneTextField, emailTextField, UIView()])
        contentView.axis = .vertical
        contentView.spacing = 16
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Registration"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextBarButtonTapped(_:)))

        setupBindings()
    }

    // MARK: - Actions

    @objc
    private func nextBarButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)

        viewModel.validate.apply().start()
    }

    // MARK: - Bindings

    private func setupBindings() {
        nameTextField <~> viewModel.name
        phoneTextField <~> viewModel.phone
        emailTextField <~> viewModel.email

        viewModel.validate.errors
            .observe(on: UIScheduler())
            .observeValues { [weak self] error in
                self?.displayValidationError(error)
            }

        viewModel.validate.completed
            .observe(on: UIScheduler())
            .observeValues { [weak self] in
                guard let self = self else { return }
                let controller = PasswordEditViewController(viewModel: self.viewModel.passwordViewModel)
                self.navigationController?.pushViewController(controller, animated: true)
            }
    }

}
