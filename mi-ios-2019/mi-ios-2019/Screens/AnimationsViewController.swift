//
//  AnimationsViewController.swift
//  mi-ios-2019
//
//  Created by Jan Misar on 09/04/2019.
//  Copyright © 2019 ČVUT. All rights reserved.
//

import UIKit

class AnimationsViewController: BaseViewController {

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

        
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: [])
        closeButton.setTitleColor(.blue, for: [])
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func closeTapped(_ sender: UIButton) {
        dismiss(animated: true) // patří do FC!!!!
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.8, animations: {
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
            panEnded(translation: translation, velocity: sender.velocity(in: view))
        default: break
        }
    }

    func panBegan() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.8, animations: {
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
    
    func panEnded(translation: CGPoint, velocity: CGPoint) {
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
        
        let velocityVector = CGVector(dx: abs(velocity.x)/100, dy: abs(velocity.y)/100)
        print(velocityVector)
        let springParameters = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: velocityVector)
        
        animator?.continueAnimation(withTimingParameters: springParameters, durationFactor: 1)
    }

}
