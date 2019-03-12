//
//  File.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ReactiveSwift

class LoginViewController : UIViewController {
    
    private var viewModel : LoginViewModel
    
    weak var usernameField : UITextField!
    weak var passwordField : UITextField!
    weak var loginButton : UIButton!

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
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
        button.tintColor = .blue
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        self.loginButton = button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        //test bindingu
        viewModel.userName.value = "TEST"
    }
    
    func setupBindings() {
        
        passwordField <~> viewModel.password
        usernameField <~> viewModel.userName
        loginButton.reactive.isEnabled <~ viewModel.canSubmitForm
        
    }
    
}
