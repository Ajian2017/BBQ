//
//  UIView+BBQAnimation.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/28.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    public func addTansition(_ duration: CFTimeInterval = 1.0,
                             _ type: CATransitionType = .fade,
                             _ subType: CATransitionSubtype? = nil) -> Self {
        let transition = makeTansition(duration: duration, type: type, subType: subType)
        self.layer.add(transition, forKey: nil)
        return self
    }

    @discardableResult
    public func scales( _ factor: CGFloat = 1.0, _ duration: CFTimeInterval = 0.25,
                        _ name: CAMediaTimingFunctionName = .easeIn) -> Self {
        let animation = makeScales(factor: factor, duration: duration, name: name)
        self.layer.add(animation, forKey: "transform.scale")
        return self
    }

    @discardableResult
    public func ratationX( _ factor: Double = 1.0, _ duration: CFTimeInterval = 0.25,
                           _ name: CAMediaTimingFunctionName = .easeIn) -> Self {
        return self.rotation("transform.rotation.x", factor, duration, name)
    }

    @discardableResult
    public func ratationY( _ factor: Double = 1.0, _ duration: CFTimeInterval = 0.25,
                           _ name: CAMediaTimingFunctionName = .easeIn) -> Self {
        return self.rotation("transform.rotation.y", factor, duration, name)
    }

    @discardableResult
    public func ratationZ( _ factor: Double = 1.0, _ duration: CFTimeInterval = 0.25,
                           _ name: CAMediaTimingFunctionName = .easeIn) -> Self {
        return self.rotation("transform.rotation.z", factor, duration, name)
    }

    @discardableResult
    public func rotation(_ path: String, _ factor: Double = 1.0, _ duration: CFTimeInterval = 0.25,
                         _ name: CAMediaTimingFunctionName = .easeIn) -> Self {
        let animation = makeRotation(path, factor, duration, name)
        self.layer.add(animation, forKey: "rotateAnimation")
        return self
    }

    @discardableResult
    public func groupAnimations(_ animations: [CAAnimation], _ repeatCount: Float = 0,  _ autoReverse: Bool = true) -> Self {
        let group = CAAnimationGroup()
        var duration: CFTimeInterval = 0.5
        animations.forEach { duration = max($0.duration, duration) }
        group.duration = duration
        group.autoreverses = autoReverse
        group.animations = animations
        group.repeatCount = repeatCount
        self.layer.add(group, forKey: "animationGroup")
        return self
    }
}

extension UIView {

    public func makeTansition(duration: CFTimeInterval = 1.0,
                              type: CATransitionType = .fade,
                              subType: CATransitionSubtype? = nil) -> CAAnimation {
        let transition = CATransition()
        transition.type = type
        if subType != nil { transition.subtype = subType }
        transition.duration = duration
        return transition
    }

    public func makeScales(factor: CGFloat = 1.0, duration: CFTimeInterval = 0.25, name: CAMediaTimingFunctionName = .easeIn) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.toValue = factor
        animation.timingFunction = CAMediaTimingFunction(name: name)
        return animation
    }

    public func makeRatationX(factor: Double = 1.0, duration: CFTimeInterval = 0.25,
                              name: CAMediaTimingFunctionName = .easeIn) -> CAAnimation {
        return self.makeRotation("transform.rotation.x", factor, duration, name)
    }

    public func makeRatationY(factor: Double = 1.0, duration: CFTimeInterval = 0.25,
                              name: CAMediaTimingFunctionName = .easeIn) -> CAAnimation {
        return self.makeRotation("transform.rotation.y", factor, duration, name)
    }

    public func makeRatationZ(factor: Double = 1.0, duration: CFTimeInterval = 0.25,
                              name: CAMediaTimingFunctionName = .easeIn) -> CAAnimation {
        return self.makeRotation("transform.rotation.z", factor, duration, name)
    }

    public func makeRotation(_ path: String,
                             _ factor: Double = 1.0,
                             _ duration: CFTimeInterval = 0.25,
                             _ name: CAMediaTimingFunctionName = .easeIn) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: path)
        animation.duration = duration
        animation.toValue = factor * 2 * Double.pi
        animation.timingFunction = CAMediaTimingFunction(name: name)
        return animation
    }
}
