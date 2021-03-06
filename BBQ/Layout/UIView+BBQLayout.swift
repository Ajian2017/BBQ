//
//  UIView+layout.swift
//  BBQKit
//
//  Created by qzjian on 2019/5/25.
//  Copyright © 2019年 qzjian. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    public func edgeInset(_ top: CGFloat = 0, _ left: CGFloat = 0,  _ bottom: CGFloat = 0, _ right: CGFloat = 0, _ targetV: UIView? = nil) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: target.topAnchor, constant: top),
            self.leftAnchor.constraint(equalTo: target.leftAnchor, constant: left),
            self.bottomAnchor.constraint(equalTo: target.bottomAnchor, constant: bottom),
            self.rightAnchor.constraint(equalTo: target.rightAnchor, constant: right)])
        return self
    }

    @discardableResult
    public func centerX(_ offset: CGFloat = 0, _ targetV: UIView? = nil) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        self.centerXAnchor.constraint(equalTo: target.centerXAnchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func centerY(_ offset: CGFloat = 0, _ targetV: UIView? = nil) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        self.centerYAnchor.constraint(equalTo: target.centerYAnchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func width(_ width: CGFloat = 0) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }

    @discardableResult
    public func height(_ height: CGFloat = 0) -> Self {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    public func widthEqualTo(_ targetV: UIView? = nil, _ multi: CGFloat = 1, _ offset: CGFloat = 0) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        self.widthAnchor.constraint(equalTo: target.widthAnchor, multiplier: multi, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func heightEqualTo(_ targetV: UIView? = nil, _ multi: CGFloat = 1, _ offset: CGFloat = 0) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        self.heightAnchor.constraint(equalTo: target.heightAnchor, multiplier: multi, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func size(_ width: CGFloat = 0, _ height: CGFloat = 0) -> Self {
        NSLayoutConstraint.activate([self.widthAnchor.constraint(equalToConstant: width),
                                     self.heightAnchor.constraint(equalToConstant: height)])
        return self
    }

    @discardableResult
    public func bottom(_ offset: CGFloat = 0, _ targetV: UIView? = nil, _ reverse: Bool = false) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        let anchor = reverse ? target.topAnchor : target.bottomAnchor
        self.bottomAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func top(_ offset: CGFloat = 0, _ targetV: UIView? = nil, _ reverse: Bool = false) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        let anchor = reverse ? target.bottomAnchor : target.topAnchor
        self.topAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func left(_ offset: CGFloat = 0, _ targetV: UIView? = nil, _ reverse: Bool = false) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        let anchor = reverse ? target.rightAnchor : target.leftAnchor
        self.leftAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func right(_ offset: CGFloat = 0, _ targetV: UIView? = nil, _ reverse: Bool = false) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        let anchor = reverse ? target.leftAnchor : target.rightAnchor
        self.rightAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func leading(_ offset: CGFloat = 0, _ targetV: UIView? = nil, _ reverse: Bool = false) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        let anchor = reverse ? target.trailingAnchor : target.leadingAnchor
        self.leadingAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func trailing(_ offset: CGFloat = 0, _ targetV: UIView? = nil, _ reverse: Bool = false) -> Self {
        let target = targetV == nil ? self.superview! : targetV!
        let anchor = reverse ? target.leadingAnchor : target.trailingAnchor
        self.trailingAnchor.constraint(equalTo: anchor, constant: offset).isActive = true
        return self
    }

    @discardableResult
    public func bbq() -> Self? {
        guard self.superview != nil else {
            print("please insure already added to a parentview")
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
