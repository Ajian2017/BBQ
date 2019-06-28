//
//  UIView+style.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/27.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        return self
    }

    @discardableResult
    public func borderWidth(_ width: CGFloat) -> Self {
        self.layer.borderWidth = width
        return self
    }

    @discardableResult
    public func borderColor(_ color: UIColor) -> Self {
        self.layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
        self.layer.opacity = opacity
        return self
    }

    @discardableResult
    public func addShadow(_ offset: CGSize, _ opacity: Float, _ radius: CGFloat, _ color: UIColor) -> Self {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        return self
    }

}
