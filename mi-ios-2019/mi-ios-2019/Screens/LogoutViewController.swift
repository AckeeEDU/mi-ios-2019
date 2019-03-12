//
//  LogoutViewController.swift
//  mi-ios-2019
//
//  Created by Dominik Vesely on 12/03/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class LogoutViewController : UIViewController {
    weak var userName : UILabel!
    weak var accessToken : UILabel!
    weak var logoutButton : UIButton!
    
    private var viewModel : LogoutViewModel
    
    init(viewModel: LogoutViewModel) {
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
        
        let nameLabel = UILabel()
        self.userName = nameLabel
        
        let accessTokenLabel = UILabel()
        self.accessToken = accessTokenLabel
        
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .disabled)
        button.tintColor = .blue
        self.logoutButton = button
        
        // ----- Stack View -----
        let stackView = UIStackView(arrangedSubviews: [nameLabel,accessTokenLabel,button])
        stackView.axis = .vertical
        stackView.spacing = 30
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview().inset(48)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setupBindings()
    }
    
    func setupBindings() {
        
        userName.reactive.text <~ viewModel.userName.map { "User: \($0)"}
        accessToken.reactive.text <~ viewModel.accessToken
        
        
    }
    
    @objc func buttonTapped(_ : Any) {
        
    }
}
