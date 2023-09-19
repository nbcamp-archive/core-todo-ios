//
//  CAAnimationGradientLayer.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-19.
//

import UIKit

class CAAnimationGradientLayer: CAGradientLayer {
    
    private let coral: CGColor = UIColor(hex: "#F94144").cgColor
    private let violet: CGColor = UIColor(hex: "#BC00DD").cgColor
    private let mustard: CGColor = UIColor(hex: "#FFD60A").cgColor
    private let green: CGColor = UIColor(hex: "#AACC00").cgColor
    
    private var gradientColorSet: [[CGColor]] = [[CGColor]]()
    
    private var currentGradientColorIndex: Int = 0
    
    override init() {
        super.init()
        
        gradientColorSet.append([coral, mustard])
        gradientColorSet.append([mustard, green])
        gradientColorSet.append([green, violet])
        gradientColorSet.append([violet, violet])
        
        self.colors = gradientColorSet[currentGradientColorIndex]
        animateGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Core Animation Delegate
extension CAAnimationGradientLayer: CAAnimationDelegate {
    func animateGradient() {
        if currentGradientColorIndex < gradientColorSet.count - 1 {
            currentGradientColorIndex += 1
        } else {
            currentGradientColorIndex = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 8.0
        gradientChangeAnimation.autoreverses = true
        gradientChangeAnimation.repeatCount = Float.infinity
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        
        gradientChangeAnimation.toValue = gradientColorSet[currentGradientColorIndex]
        
        add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            colors = gradientColorSet[currentGradientColorIndex]
            CATransaction.commit()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animateGradient()
            }
        }
    }
}
