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
    public func cornerRadius(_ radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        return self
    }

    @discardableResult
    public func borderWidth(_ width: CGFloat) -> UIView {
        self.layer.borderWidth = width
        return self
    }

    @discardableResult
    public func borderColor(_ color: UIColor) -> UIView {
        self.layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    public func opacity(_ opacity: Float) -> UIView {
        self.layer.opacity = opacity
        return self
    }
}
