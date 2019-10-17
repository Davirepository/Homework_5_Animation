//
//  ViewController.swift
//  HW_Animations
//
//  Created by Давид on 17/10/2019.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sun"), for: .normal)
        button.frame = CGRect(x: view.frame.width / 2 - 50, y: view.frame.height / 2 - 50, width: 100, height: 100)
        button.layer.cornerRadius = button.layer.bounds.width / 2
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStop: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitle("Stop animation", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 32, y: 800, width: view.frame.width - 64, height: 50)
        button.layer.cornerRadius = 4
        button.isHidden = true
        button.addTarget(self, action: #selector(tapStopButton), for: .touchUpInside)
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        view.addSubview(buttonStop)
        view.addSubview(button)
    }

    @objc func tapButton() {
        UIView.animate(withDuration: 6.0,
                       delay: 0.0,
                       options: [.curveLinear, .repeat],
                       animations: {
                        self.button.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (_) in
            self.button.transform = CGAffineTransform.identity
        }
        
        let transformScaleX = CABasicAnimation(keyPath: "transform.scale.x")
        transformScaleX.fromValue = 1
        transformScaleX.toValue = 2
        transformScaleX.beginTime = 1.0
        
        let transformeScaleY = CABasicAnimation(keyPath: "transform.scale.y")
        transformeScaleY.fromValue = 1
        transformeScaleY.toValue = 2
        transformScaleX.beginTime = 1.0
        
        let moveToCenter = CABasicAnimation(keyPath: "position");
        moveToCenter.fromValue = [view.frame.width, 0]
        moveToCenter.toValue = [view.frame.width / 2, view.frame.height / 2]
        
        let changeViewBackground = CABasicAnimation(keyPath: "backgroundColor");
        changeViewBackground.fromValue = UIColor.white.cgColor
        changeViewBackground.toValue = UIColor.yellow.cgColor
        changeViewBackground.duration = 6.0
        changeViewBackground.autoreverses = true
        
        let groupOfAnimations = CAAnimationGroup()
        groupOfAnimations.animations = [transformScaleX, transformeScaleY, moveToCenter]
        groupOfAnimations.duration = 6.0
        groupOfAnimations.autoreverses = true
        
        view.layer.add(changeViewBackground, forKey: "changeViewBackground")
        button.layer.add(groupOfAnimations, forKey: "groupOfAnimations")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(12)) {
            self.buttonStop.isHidden = false
        }
        
    }
    
    @objc func tapStopButton() {
        button.layer.removeAllAnimations()
        view.layer.removeAllAnimations()
        buttonStop.isHidden = true
    }

}

