//
//  StyleViewController.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/27.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

class StyleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let demoView = UIButton()
        let cornerBtn = CommonUtil.makeButton("corner")
        let opacityBtn = CommonUtil.makeButton("opacity")
        let bordersBtn = CommonUtil.makeButton("borders")
        let colorBtn = CommonUtil.makeButton("color")
        let views = [cornerBtn, opacityBtn, bordersBtn, colorBtn, demoView]
        views.forEach { view.addSubview($0) }

        cornerBtn.bbq()?.leading(50).top(50).size(80, 50)
        opacityBtn.bbq()?.trailing(-50).top(50).size(80, 50)
        bordersBtn.bbq()?.leading(50).top(10, cornerBtn, true).size(80, 50)
        colorBtn.bbq()?.trailing(-50).top(10, cornerBtn, true).size(80, 50)

        cornerBtn.onTap { (_) in
            demoView.cornerRadius(20)
            }.addOwner(self)

        bordersBtn.onTap { (_) in
            demoView.borderWidth(5)
            }.addOwner(self)

        demoView.onTap { (_) in
            self.dismiss(animated: true, completion: nil)
        }.addOwner(self)

        opacityBtn.onTap { (_) in
            demoView.opacity(0.2)
        }.addOwner(self)

        colorBtn.onTap { (bt) in
            demoView.borderColor(.purple)
        }.addOwner(self)

        demoView.bbq()?.centerX().centerY().size(300, 300)
        demoView.backgroundColor = .green
    }
}
