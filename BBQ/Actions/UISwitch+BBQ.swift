//
//  UISwitch+BBQ.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/18.
//  Copyright © 2019年 qzjian. All rights reserved.
//

import UIKit

public typealias SwitchChangeBlock = (UISwitch) -> Void
public class DisposebleSwitch {
    static var disposeBag = [DisposebleSwitch]()
    let switchChangeBlock: SwitchChangeBlock?
    weak var owner: NSObject?

    init(_ block: @escaping SwitchChangeBlock) {
        self.switchChangeBlock = block
    }

    public func addOwener(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleSwitch.disposeBag.append(self)
    }

    @objc func onValueChange(_ sender: UISwitch) {
        self.switchChangeBlock?(sender)
    }

    static func create(_ block: @escaping SwitchChangeBlock) -> DisposebleSwitch {
        return DisposebleSwitch(block)
    }

    public func dispose() {
        let newdispose = DisposebleSwitch.disposeBag.filter { $0.owner != nil }
        DisposebleSwitch.disposeBag = newdispose
    }
}

extension UISwitch {
    public func onToggle(_ block: @escaping SwitchChangeBlock) -> DisposebleSwitch {
        let dispose = DisposebleSwitch.create(block)
        self.addTarget(dispose, action:#selector(DisposebleSwitch.onValueChange(_:)), for: .valueChanged)
        return dispose
    }
}
