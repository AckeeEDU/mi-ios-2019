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
    
    var animator: UIViewPropertyAnimator?
    
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
                animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1, animations: {
                    self.interactiveView.snp.updateConstraints { make in
                        make.width.equalTo(300)
                        make.height.equalTo(400)
                    }
                    
                    self.view.layoutIfNeeded()
                })
                animator?.addCompletion({ _ in
                    self.interactiveViewState = .large
                })
                animator?.startAnimation()
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
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began:
            panBegan()
        case .changed:
            panChanged(translation: translation)
        case .ended:
            let velocity = sender.velocity(in: view)
            panEnded(translation: translation, velocity: velocity)
        default: break
        }
    }
    
    func panBegan() {
        
    }
    
    func panChanged(translation: CGPoint) {
        let height = min(150 - translation.y, 400)
        let width = min(200 - translation.x, 300)
        
        print(height)
        print(width)
        
        self.interactiveView.snp.updateConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        self.view.layoutIfNeeded()
    }
    
    func panEnded(translation: CGPoint, velocity: CGPoint) {
        
    }
}
