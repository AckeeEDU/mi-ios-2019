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

class LoginViewController : UIViewController {
    
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
        
        let passwordField = UITextField()
        view.addSubview(passwordField)
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = .white
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameField.snp.bottom).offset(30)
            make.height.equalTo(usernameField)
            make.leading.trailing.equalTo(usernameField)
        }
        
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.tintColor = .blue
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
}
