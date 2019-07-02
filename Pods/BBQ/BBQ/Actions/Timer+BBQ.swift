//
//  Timer+BBQ.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/7/2.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public typealias TimerClosure = (Timer) -> Void

public class DisposebleTimer {

    static var disposeBag = [DisposebleTimer]()
    let timerClosure: TimerClosure?
    weak var owner: NSObject?

    init(_ block: @escaping TimerClosure) {
        self.timerClosure = block
    }

    public func addOwner(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleTimer.disposeBag.append(self)
    }

    static func create(_ block: @escaping TimerClosure) -> DisposebleTimer {
        return DisposebleTimer(block)
    }

    @objc func timerTriggerAction(_ timer: Timer) {
        guard owner != nil else {
            timer.invalidate()
            return
        }
        self.timerClosure?(timer)
    }

    func dispose() {
        let newDispose = DisposebleTimer.disposeBag.filter { $0.owner != nil }
        DisposebleTimer.disposeBag = newDispose
    }
}

extension DisposebleTimer {
    public class func schedule(_ interval: TimeInterval, _ repeats: Bool, _ closure: @escaping (Timer) -> Void) -> DisposebleTimer  {
        let dispose = DisposebleTimer.create(closure)
        let timer = Timer(timeInterval: interval, target: dispose, selector: #selector(DisposebleTimer.timerTriggerAction(_:)), userInfo: nil, repeats: repeats)
        RunLoop.main.add(timer, forMode: .common)
        return dispose
    }
}
