//
//  CommonUtil.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/25.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

let headerID = "header"
let footerID = "footer"

class CommonUtil {
    static func makeButton(_ title: String) -> UIButton {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .green
        bt.setTitle(title, for: .normal)
        bt.setTitleColor(.red, for: .normal)
        bt.layer.cornerRadius = 5
        return bt
    }
}
