//
//  UITextView+BBQ.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/18.
//  Copyright © 2019年 qzjian. All rights reserved.
//

import UIKit

public typealias TextViewChangeBlock = (UITextView) -> Void

public class DisposebleTextView: NSObject,UITextViewDelegate {
    static var disposeBag = [DisposebleTextView]()
    let textViewChangeBlock: TextViewChangeBlock?
    weak var owner: NSObject?

    init(_ block: @escaping TextViewChangeBlock) {
        self.textViewChangeBlock = block
    }

    public func addOwener(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleTextView.disposeBag.append(self)
    }

    static func create(_ block: @escaping TextViewChangeBlock) -> DisposebleTextView {
        return DisposebleTextView(block)
    }

    public func dispose() {
        let newdispose = DisposebleTextView.disposeBag.filter { $0.owner != nil }
        DisposebleTextView.disposeBag = newdispose
    }

    /// textView text change delegate method
    ///
    /// - Parameter textView: the textView which text change
    public func textViewDidChange(_ textView: UITextView) {
        self.textViewChangeBlock?(textView)
    }
}

extension UITextView {

    public func onTextChange(_ block: @escaping TextViewChangeBlock) -> DisposebleTextView {
        let dispose = DisposebleTextView.create(block)
        self.delegate = dispose
        return dispose
    }
}
