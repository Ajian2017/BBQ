//
//  NotificationCenter+BBQ.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/20.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public typealias NotificationBlock = (Notification) -> Void
public class DisposebleNotification {
    static var disposeBag = [DisposebleNotification]()
    let notificationBlock: NotificationBlock?
    let notificationName: String

    weak var owner: NSObject?
    init(_ name: String ,_ block: @escaping NotificationBlock) {
        self.notificationBlock = block
        self.notificationName = name
    }

    static func create(_ name: String, _ block: @escaping NotificationBlock) -> DisposebleNotification {
        return DisposebleNotification(name, block)
    }

    public func addOwner(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleNotification.disposeBag.append(self)
    }

    @objc func onReceiveNotification(_ notifi: Notification) {
        guard owner != nil else { return }
        self.notificationBlock?(notifi)
    }

    /// remove and update observers
    func dispose() {
        let discardDispose = DisposebleNotification.disposeBag.filter { $0.owner == nil }
        for discard in discardDispose {
            NotificationCenter.default.removeObserver(discard, name: NSNotification.Name(rawValue: discard.notificationName), object: nil)
        }
        let newDispose = DisposebleNotification.disposeBag.filter { $0.owner != nil }
        DisposebleNotification.disposeBag = newDispose
    }
}

extension NotificationCenter {

    public func registerNotification(_ name: String, _ callback: @escaping NotificationBlock) -> DisposebleNotification {
        let dispose = DisposebleNotification.create(name, callback)
        NotificationCenter.default.addObserver(dispose, selector: #selector(DisposebleNotification.onReceiveNotification(_:)), name: NSNotification.Name(rawValue: name), object: nil)
        return dispose
    }

    public func bbqPost(_ name: String, _ object: Any?, _ userInfo: [AnyHashable : Any]? = nil) {
        return self.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo )
    }
}
