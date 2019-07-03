//
//  ViewController.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/21.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit
import BBQ

class ViewController: UIViewController {

    var table: UITableView?
    var proxy: BBQTableViewProxy<Any>?
    var sectionDataProxy: BBQSectionTableViewProxy?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.registerNotification("btnclick") { (notifi) in
            print(notifi)
        }.addOwner(self)

        setupUIContols()
        view.backgroundColor = .white

        let ds = BBQTableViewProxy<Any>(
            models: ["CollectionView", "CollectionViewSection","default"],
            reuseIdentifier: "message"
        ) { model, cell in
            let md = model as! String
            cell.textLabel?.text = md
        }
        ds.setFirstCellExpandable(true)
        ds.setCellEditConfigBlock { (row) in return row != 0 }
        ds.setCellHeightConfig { (_) in return 50 }
        ds.setHeaderHeightConfig { return 35 }
        ds.setHeaderConfig("header") {
            let lb = UILabel()
            lb.text = "header1"
            lb.backgroundColor = .lightGray
            return lb
        }

        ds.setFooterHeightConfig { return 0.1 }
        ds.setFooterConfig("footer") {
            let lb = UILabel()
            lb.text = "footer1"
            lb.backgroundColor = .lightGray
            return lb
        }

        ds.setCellClickBlock({ [weak self] (model) in
            let md = model as! String
            print("you click \(md)")
            if md == "CollectionView" {
                let cv = CollectionViewController()
                self?.present(cv, animated: true, completion: nil)
            }else {
                let cv = SectionCollectionViewController()
                self?.present(cv, animated: true, completion: nil)
            }
        })

        proxy = ds

        let ds2 = BBQTableViewProxy<Any>(models: ["style", "animation"], reuseIdentifier: "message") { model, cell in
            let md = model as! String
            cell.textLabel?.text = md
        }
        ds2.setFooterHeightConfig { return 35 }
        ds2.setFooterConfig("footer") {
            let lb = UILabel()
            lb.text = "footer2"
            lb.backgroundColor = .gray
            return lb
        }
        ds2.setCellClickBlock({ [weak self] (model) in
            let md = model as! String
            print("you click \(md)")
            if md == "style" {
                let vc = StyleViewController()
                self?.present(vc, animated: true, completion: nil)
            }
            else {
                let vc = AnimationViewController()
                self?.present(vc, animated: true, completion: nil)
            }
        })

        sectionDataProxy = BBQSectionTableViewProxy(tableProxys: [ds, ds2])

        table = UITableView(frame: .zero, style: .plain)
        table?.register(UITableViewCell.self, forCellReuseIdentifier: "message")
        table?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        table?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")

        view.addSubview(table!)
        table?.bbq()?.top(350).left(15).trailing(-15).bottom()
        table?.dataSource = sectionDataProxy
        table?.delegate = sectionDataProxy
        //        table?.dataSource = proxy
        //        table?.delegate = proxy
    }

    func setupUIContols() {
        let bt = CommonUtil.makeButton("btn")
        view.addSubview(bt)
        bt.bbq()!.top(120).centerX().size(80, 60)

        bt.onTap {[weak self] (sender) in
            print("you click \(sender)")
            NotificationCenter.default.bbqPost("btnclick", nil, ["msg": bt])
            self?.present(ViewController(), animated: true) {}
        }.addOwner(self)

        let bt2 = CommonUtil.makeButton("btn2")
        view.addSubview(bt2)
        bt2.bbq()!.left(50).top(50).size(80, 60)
        bt2.onTap(.touchUpInside, {[weak self] (bt) in
            self?.dismiss(animated: true, completion: nil)
        }).addOwner(self)

        let swc = UISwitch()
        view.addSubview(swc)
        swc.bbq()!.left(20, bt2, true).centerY(0, bt2)
        swc.onToggle { [weak self] (sender) in
            print(sender.isOn)
            self?.table?.setEditing(sender.isOn, animated: true)}.addOwner(self)

        let slider = UISlider()
        slider.minimumValue = -1.0;
        slider.maximumValue = 1.0;
        slider.value = 0.0;
        view.addSubview(slider)
        slider.bbq()!.left(20, swc, true).centerY(0, swc).width(100).height(20)
        slider.onValueChanged { (slider) in
            print(slider.value)
        }.addOwner(self)

        let tf = UITextField()
        view.addSubview(tf)
        tf.bbq()!.top(30, bt, true).centerX().size(200, 50)
        tf.backgroundColor = .green
        tf.onTextChange { (sender) in print(sender.text ?? "")}.addOwner(self)

        let tvf = UITextView()
        view.addSubview(tvf)
        tvf.bbq()!.top(30, tf, true).centerX().size(200, 50)
        tvf.backgroundColor = .red
        tvf.onTextChange { (sender) in print(sender.text ?? "") }.addOwner(self)
    }
    deinit { print(#function) }
}
