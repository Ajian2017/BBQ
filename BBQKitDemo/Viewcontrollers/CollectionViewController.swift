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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray

        let close = CommonUtil.makeButton("close")
        view.addSubview(close)
        close.bbq()!.left(50).top(30).size(60, 50)
        close.onTap(.touchUpInside, {[weak self] (bt) in
            self?.dismiss(animated: true, completion: nil)
        }).addOwner(self)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.cellSize(80, 80).lineSpace(5)
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .lightGray
        view.addSubview(collection)
        collection.bbq()?.top(20, close, true).bottom().leading().trailing()
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collection.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collection.register(CollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)

        //config cell
        let proxy = BBQCollectionViewProxy<String>(models: ["3.jpg", "4.jpg", "8.jpg", "14.jpg", "3.jpg", "4.jpg", "8.jpg"],
                                                   collectionView: collection,
                                                   reuseIdentifier: "CollectionViewCell") { (imgname, cell) in
            let ccell = cell as! CollectionViewCell
            ccell.imagView.image = UIImage(named: imgname)
        }

        //config click callback
        proxy.setCellClickBlock { (imgname) in print(imgname) }

        //config header
        proxy.setHeaderConfig { (indexPath, collectionView) in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CollectionViewHeader
            header.imageView.image = UIImage(named: "space.jpg")
            return header
        }

        //config layout
        proxy.setCellSizeClosure { (row) in
            if row % 2 == 0 {
                return CGSize(width: Int.random(in: 80...160), height: Int.random(in: 80...160))
            }
            return CGSize(width: 80, height: 80)
        }
        proxy.setHeaderSizeClosure { return CGSize(width: 200, height: 200) }
        proxy.setFooterSizeClosure { return CGSize(width: 200, height: 200)}
        proxy.setLineSpaceClosure { return 20  }
        proxy.setInterSpaceClosure { return 10 }
        proxy.setInsetsClosure { return UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50) }

        //config footer
        proxy.setFooterConfig() { (indexPath, collectionView) in
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID, for: indexPath) as! CollectionViewFooter
            footer.imageView.image = UIImage(named: "footer.jpg")
            return footer
        }
        collection.dataSource = proxy
        collection.delegate = proxy
        self.proxy = proxy
    }
}
