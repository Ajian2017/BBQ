//
//  UIButton+BBQ.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/4.
//  Copyright © 2019年 qzjian. All rights reserved.
//

import UIKit

typealias TapBlock = (UIButton) -> Void

class DisposebleBtn {
    static var disposeBag = [DisposebleBtn]()
    let tabBlock: TapBlock?
    weak var owner: NSObject?
    init(_ block: @escaping TapBlock) {
        self.tabBlock = block
    }

    func addOwener(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleBtn.disposeBag.append(self)
    }

    @objc func onTapAction(_ bt: UIButton) {
        self.tabBlock?(bt)
    }

    static func create(_ block: @escaping TapBlock) -> DisposebleBtn {
        return DisposebleBtn(block)
    }

    func dispose() {
        var newDispose = [DisposebleBtn]()
        for dis in DisposebleBtn.disposeBag where dis.owner != nil {
            newDispose.append(dis)
        }
        DisposebleBtn.disposeBag = newDispose
    }
}

extension UIButton {

    func onTap(_ event: UIControl.Event, _ block: @escaping TapBlock) -> DisposebleBtn {
        let dispose = DisposebleBtn.create(block)
        self.addTarget(dispose, action: #selector(DisposebleBtn.onTapAction(_:)), for: event)
        return dispose
    }

    func onTap(_ block: @escaping TapBlock) -> DisposebleBtn {
        return onTap(.touchUpInside, block)
    }
}
