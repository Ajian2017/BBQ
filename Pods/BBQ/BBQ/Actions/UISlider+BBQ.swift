//
//  UISlider+BBQ.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/27.
//  Copyright © 2019 qzjian. All rights reserved.
//
import UIKit

public typealias SliderChangeBlock = (UISlider) -> Void
public class DisposebleSlider {
    static var disposeBag = [DisposebleSlider]()
    let sliderChangeBlock: SliderChangeBlock?
    weak var owner: NSObject?

    init(_ block: @escaping SliderChangeBlock) {
        self.sliderChangeBlock = block
    }

    public func addOwner(_ obj: NSObject) {
        dispose()
        owner = obj
        DisposebleSlider.disposeBag.append(self)
    }

    @objc func onValueChange(_ sender: UISlider) {
        guard owner != nil else { return }
        self.sliderChangeBlock?(sender)
    }

    static func create(_ block: @escaping SliderChangeBlock) -> DisposebleSlider {
        return DisposebleSlider(block)
    }

    public func dispose() {
        let newdispose = DisposebleSlider.disposeBag.filter { $0.owner != nil }
        DisposebleSlider.disposeBag = newdispose
    }
}

extension UISlider {
    public func onValueChanged(_ block: @escaping SliderChangeBlock) -> DisposebleSlider {
        let dispose = DisposebleSlider.create(block)
        self.addTarget(dispose, action:#selector(DisposebleSlider.onValueChange(_:)), for: .valueChanged)
        return dispose
    }
}
