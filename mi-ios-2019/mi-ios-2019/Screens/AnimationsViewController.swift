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
                animate(to: .large)
            case .large:
                animate(to: .small)
            }
        }
    }
    
    func animate(to state: State) {
        interactiveView.snp.updateConstraints { make in
            make.height.equalTo(state.height)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.interactiveViewState = state
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
        if -translation.y > (State.large.height - State.small.height)/3 {
            animate(to: .large)
        } else {
            animate(to: .small)
        }
    }

}
