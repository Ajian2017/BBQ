//
//  AnimationViewController.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/28.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let demoView = UIButton()
        let shadowBtn = CommonUtil.makeButton("shadow")
        let scaleBtn = CommonUtil.makeButton("scale")
        let rotationBtn = CommonUtil.makeButton("rotation")
        let transitionBtn = CommonUtil.makeButton("transition")
        let groupBtn = CommonUtil.makeButton("group")
        let views = [shadowBtn, scaleBtn, rotationBtn, transitionBtn, groupBtn, demoView]
        views.forEach { view.addSubview($0) }

        shadowBtn.bbq()?.leading(50).top(50).size(80, 50)
        scaleBtn.bbq()?.trailing(-50).top(50).size(80, 50)
        rotationBtn.bbq()?.leading(50).top(10, shadowBtn, true).size(80, 50)
        transitionBtn.bbq()?.trailing(-50).top(10, shadowBtn, true).size(80, 50)
        groupBtn.bbq()?.centerX().top(85).size(80, 50)

        shadowBtn.onTap { (_) in
            demoView.addShadow(CGSize(width: 10, height: 10), 0.5, 10, .red)
        }.addOwner(self)

        groupBtn.onTap { (_) in
            let animation1 = demoView.makeRatationX(factor: 1, duration: 10)
            let animation2 = demoView.makeRatationY(factor: 1, duration: 10)
            let animation3 = demoView.makeRatationZ(factor: 1, duration: 10)
            let animation4 = demoView.makeTansition(duration: 10, type: .moveIn)
            let animation5 = demoView.makeScales(factor: 0.5, duration: 10)
            demoView.groupAnimations([animation1, animation2, animation3, animation4, animation5])
        }.addOwner(self)

        scaleBtn.onTap { (_) in
            demoView.scales(0.5, 0.5, .easeIn).size(150, 150)
        }.addOwner(self)

        transitionBtn.onTap { (_) in
            demoView.addTansition(1).opacity(1)
        }.addOwner(self)

        demoView.onTap { (_) in
            self.dismiss(animated: true, completion: nil)
        }.addOwner(self)

        rotationBtn.onTap { (_) in
            demoView.scales(0.5).ratationZ()
            }.addOwner(self)

        demoView.bbq()?.centerX().centerY().size(250, 250)
        demoView.backgroundColor = .purple
    }
}
