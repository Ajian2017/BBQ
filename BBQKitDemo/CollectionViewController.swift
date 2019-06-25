//
//  CollectionViewController.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/24.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit
import BBQ

class CollectionViewController: UIViewController {

    var proxy: BBQCollectionViewProxy<String>?

    func makeButton(_ title: String) -> UIButton {
        let bt = UIButton(type: .custom)
        bt.backgroundColor = .green
        bt.setTitle(title, for: .normal)
        bt.setTitleColor(.red, for: .normal)
        return bt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray

        let bt2 = makeButton("close")
        view.addSubview(bt2)
        bt2.bbq()!.left(50).top(50).size(100, 80)
        bt2.onTap(.touchUpInside, {[weak self] (bt) in
            self?.dismiss(animated: true, completion: nil)
        }).addOwener(self)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.cellSize(80, 80).lineSpace(5).headerSize(view.bounds.width, 100).footerSize(view.bounds.width, 100)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .lightGray
        view.addSubview(collection)
        collection.bbq()?.top(30, bt2, true).bottom().leading().trailing()
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collection.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collection.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")

        //config cell
        let proxy = BBQCollectionViewProxy<String>(models: ["3.jpg", "4.jpg", "8.jpg", "14.jpg", "3.jpg", "4.jpg", "8.jpg", "14.jpg"], reuseIdentifier: "CollectionViewCell") { (imgname, cell) in
            let ccell = cell as! CollectionViewCell
            ccell.imagView.image = UIImage(named: imgname)
        }

        //config click callback
        proxy.setCellClickBlock { (imgname) in print(imgname) }

        //config header
        proxy.setHeaderConfigClosure { (collectionView, indexPath)  in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! CollectionViewHeader
            header.imageView.image = UIImage(named: "space.jpg")
            return header
        }

        //config footer
        proxy.setFooterConfigClosure { (collectionView, indexPath) in
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! CollectionViewHeader
            footer.imageView.image = UIImage(named: "footer.jpg")
            return footer
        }
        collection.dataSource = proxy
        collection.delegate = proxy
        self.proxy = proxy
    }
}
