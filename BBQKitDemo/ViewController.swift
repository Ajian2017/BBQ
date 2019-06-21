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
        }.addOwener(self)

        setupUIContols()

        let ds = BBQTableViewProxy<Any>(
            models: [("msg1", "this is first message"), ("msg2", "this is second message")],
            reuseIdentifier: "message"
        ) { model, cell in
            let md = model as! (String, String)
            cell.textLabel?.text = md.0
            cell.detailTextLabel?.text = md.1
        }
        ds.setCellEditConfigBlock { (row) in
            return row != 0
        }
        ds.setCellHeightConfig { (_) in return 50 }
        ds.setHeaderHeightConfig { return 22 }
        ds.setHeaderConfig("header") {
            let lb = UILabel()
            lb.text = "header1"
            lb.backgroundColor = .gray
            return lb
        }

        ds.setFooterHeightConfig { return 22 }
        ds.setFooterConfig("footer") {
            let lb = UILabel()
            lb.text = "footer1"
            lb.backgroundColor = .gray
            return lb
        }

        ds.setCellClickBlock({ (model) in
            let md = model as! (String, String)
            print("you click \(md.0)")
        })

        proxy = ds

        let ds2 = BBQTableViewProxy<Any>(
            models: [("msg3", "this is three message"), ("msg4", "this is four message")],
            reuseIdentifier: "message"
        ) { model, cell in
            let md = model as! (String, String)
            cell.textLabel?.text = md.0
            cell.detailTextLabel?.text = md.1
        }
        ds2.setFooterHeightConfig { return 22 }
        ds2.setFooterConfig("footer") {
            let lb = UILabel()
            lb.text = "footer2"
            lb.backgroundColor = .gray
            return lb
        }
        ds2.setCellClickBlock({ (model) in
            let md = model as! (String, String)
            print("you click \(md.0)")
        })

        sectionDataProxy = BBQSectionTableViewProxy(dataSources: [ds, ds2])

        table = UITableView(frame: .zero, style: .plain)
        table?.register(UITableViewCell.self, forCellReuseIdentifier: "message")
        table?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        table?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")

        view.addSubview(table!)
        table?.bbq()?.top(400).left(15).trailing(-15).bottom()
        table?.dataSource = sectionDataProxy
        table?.delegate = sectionDataProxy
        //        table?.dataSource = proxy
        //        table?.delegate = proxy

    }

    func makeButton(_ title: String) -> UIButton {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .green
        bt.setTitle(title, for: .normal)
        bt.setTitleColor(.red, for: .normal)
        return bt
    }

    func setupUIContols() {
        let bt = makeButton("demo")
        view.addSubview(bt)
        bt.bbq()!.top(150).centerX().size(100, 80)

        bt.onTap {[weak self] (sender) in
            print("you click \(sender)")
            NotificationCenter.default.bbqPost("btnclick", nil, ["msg": bt])
            self?.present(ViewController(), animated: true) {}
            }.addOwener(self)

        let bt2 = makeButton("demo2")
        view.addSubview(bt2)
        bt2.bbq()!.left(50).top(50).size(100, 80)
        bt2.onTap(.touchUpInside, {[weak self] (bt) in
            self?.dismiss(animated: true, completion: nil)
        }).addOwener(self)

        let swc = UISwitch()
        view.addSubview(swc)
        swc.bbq()!.left(20, bt2, true).centerY(0, bt2)
        swc.onToggle { [weak self] (sender) in
            print(sender.isOn)
            self?.table?.setEditing(sender.isOn, animated: true)}.addOwener(self)

        let tf = UITextField()
        view.addSubview(tf)
        tf.bbq()!.top(30, bt, true).centerX().size(200, 50)
        tf.backgroundColor = .green
        tf.onTextChange { (sender) in print(sender.text ?? "")}.addOwener(self)

        let tvf = UITextView()
        view.addSubview(tvf)
        tvf.bbq()!.top(30, tf, true).centerX().size(200, 50)
        tvf.backgroundColor = .red
        tvf.onTextChange { (sender) in print(sender.text) }.addOwener(self)
    }

    deinit {
        print(#function)
    }
}

