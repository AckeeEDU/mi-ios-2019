//
//  AnimationsViewController.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 09/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class AnimationsViewController: UIViewController {

    enum State {
        case small, large
    }
    
    private(set) weak var interactiveView: UIView!
    var interactiveViewState: State = .small
    
    weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let interactiveView = UIView()
        interactiveView.backgroundColor = .blue
        view.addSubview(interactiveView)
        interactiveView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(150)
        }
        self.interactiveView = interactiveView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        interactiveView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            switch interactiveViewState {
            case .small:
                interactiveView.snp.updateConstraints { make in
                    make.width.equalTo(300)
                    make.height.equalTo(400)
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.interactiveViewState = .large
                }
            case .large:
                interactiveView.snp.updateConstraints { make in
                    make.width.equalTo(200)
                    make.height.equalTo(150)
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.interactiveViewState = .small
                }
            }
        }
    }
    
    
}
