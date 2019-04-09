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
        
        var oposite: State {
            switch self {
            case .small: return .large
            case .large: return .small
            }
        }
    }
    
    private(set) weak var interactiveView: UIView!
    var interactiveViewState: State = .small
    
    var animator: UIViewPropertyAnimator?
    
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
            animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
                self.setHeight(to: self.interactiveViewState.oposite)
            })
            animator?.addCompletion({ _ in
                self.interactiveViewState = self.interactiveViewState.oposite
            })
            animator?.startAnimation()
        }
    }
    
    func setHeight(to state: State) {
        interactiveView.snp.updateConstraints { make in
            make.height.equalTo(state.height)
        }
        self.view.layoutIfNeeded()
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
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
            self.setHeight(to: self.interactiveViewState.oposite)
        })
    }
    
    func panChanged(translation: CGPoint) {
        var progress = translation.y / 500
        
        if interactiveViewState == .small {
            progress = -1 * progress
        }
        
        progress = max(CGFloat.leastNonzeroMagnitude, min(1-CGFloat.leastNonzeroMagnitude, progress))
        
        animator?.fractionComplete = progress
    }
    
    func panEnded(translation: CGPoint) {
        switch interactiveViewState {
        case .small:
            if -translation.y > (State.large.height - State.small.height)/5 {
                animator?.addCompletion { _ in
                    self.interactiveViewState = self.interactiveViewState.oposite
                }
            } else {
                animator?.isReversed = true
                animator?.addCompletion { _ in
                    self.setHeight(to: self.interactiveViewState)
                }
            }
        case .large:
            if translation.y < (State.large.height - State.small.height)/5 {
                animator?.isReversed = true
                animator?.addCompletion { _ in
                    self.setHeight(to: self.interactiveViewState)
                }
            } else {
                animator?.addCompletion { _ in
                    self.interactiveViewState = self.interactiveViewState.oposite
                }
            }
        }
        
        animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1)
    }

}
