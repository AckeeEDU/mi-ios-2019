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
        
        var height: CGFloat {
            switch self {
            case .small: return 100
            case .large: return 600
            }
        }
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
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        self.interactiveView = interactiveView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        interactiveView.addGestureRecognizer(tapGestureRecognizer)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        interactiveView.addGestureRecognizer(panGestureRecognizer)

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
                    make.height.equalTo(State.large.height)
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.interactiveViewState = .large
                }
            case .large:
                interactiveView.snp.updateConstraints { make in
                    make.height.equalTo(State.small.height)
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.interactiveViewState = .small
                }
            }
        }
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began:
            panBegan()
        case .changed:
            panChanged(translation: translation)
        case .ended:
            panEnded(translation: translation)
        default: break
        }
    }

    func panBegan() {
        
    }
    
    func panChanged(translation: CGPoint) {
        let height = max(min(State.small.height - translation.y, State.large.height), State.small.height)
        
        self.interactiveView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        self.view.layoutIfNeeded()
    }
    
    func panEnded(translation: CGPoint) {
        
    }

}
