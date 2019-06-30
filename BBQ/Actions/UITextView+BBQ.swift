//
//  UITextView+BBQ.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/18.
//  Copyright © 2019年 qzjian. All rights reserved.
//

import UIKit

public class DisposebleTextView: NSObject,UITextViewDelegate {
    public typealias TextChangeBlock = (UITextView) -> Void

    static var disposeBag = [DisposebleTextView]()
    let textChangeBlock: TextChangeBlock?
    weak var owner: NSObject?

    init(_ block: @escaping TextChangeBlock) {
        self.textChangeBlock = block
    }

    public func addOwner(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleTextView.disposeBag.append(self)
    }

    static func create(_ block: @escaping TextChangeBlock) -> DisposebleTextView {
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
        guard owner != nil else { return }
        self.textChangeBlock?(textView)
    }
}

extension UITextView {

    public func onTextChange(_ block: @escaping DisposebleTextView.TextChangeBlock) -> DisposebleTextView {
        let dispose = DisposebleTextView.create(block)
        self.delegate = dispose
        return dispose
    }
}
