//
//  UITextField+BBQ.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/17.
//  Copyright © 2019年 qzjian. All rights reserved.
//

import UIKit

public class DisposebleTextField {
    public typealias TextChangeBlock = (UITextField) -> Void
    static var disposeBag = [DisposebleTextField]()
    let textChangeBlock: TextChangeBlock?
    weak var owner: NSObject?

    init(_ block: @escaping TextChangeBlock) {
        self.textChangeBlock = block
    }

    public func addOwner(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleTextField.disposeBag.append(self)
    }

    @objc func onTextChange(_ textfield: UITextField) {
        guard owner != nil else { return }
        self.textChangeBlock?(textfield)
    }

    static func create(_ block: @escaping TextChangeBlock) -> DisposebleTextField {
        return DisposebleTextField(block)
    }

    public func dispose() {
        var newDispose = [DisposebleTextField]()
        for dis in DisposebleTextField.disposeBag where dis.owner != nil {
            newDispose.append(dis)
        }
        DisposebleTextField.disposeBag = newDispose
    }
}

extension UITextField {

    public func onTextChange(_ event: UIControl.Event, _ block: @escaping DisposebleTextField.TextChangeBlock) -> DisposebleTextField {
        let dispose = DisposebleTextField.create(block)
        self.addTarget(dispose, action: #selector(DisposebleTextField.onTextChange(_:)), for: event)
        return dispose
    }

    public func onTextChange(_ block: @escaping DisposebleTextField.TextChangeBlock) -> DisposebleTextField {
        return onTextChange(.editingChanged, block)
    }
}
