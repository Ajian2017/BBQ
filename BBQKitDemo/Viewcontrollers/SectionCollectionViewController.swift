//
//  SectionCollectionViewController.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/25.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit
import BBQ

class SectionCollectionViewController: UIViewController {

    var sectionProxy: BBQSectionCollectionViewProxy?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let close = CommonUtil.makeButton("close")
        view.addSubview(close)
        close.bbq()!.left(50).top(30).size(60, 50)
        close.onTap(.touchUpInside, {[weak self] (bt) in
            self?.dismiss(animated: true, completion: nil)
        }).addOwner(self)

        let flowLayout = UICollectionViewFlowLayout()

        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .lightGray
        view.addSubview(collection)
        collection.bbq()?.top(20, close, true).bottom().leading().trailing()
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collection.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collection.register(CollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)

        let proxy1: BBQCollectionViewProxy<Any> = makeSection1(collection)
        let proxy2: BBQCollectionViewProxy<Any> = makeSection2(collection)
        sectionProxy = BBQSectionCollectionViewProxy(collectionProxys: [proxy1, proxy2])

        sectionProxy?.setHeaderConfigClosure() { (indexPath, collectionView) in
            //map indexpath.section to reuseIdentifier
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CollectionViewHeader
            header.imageView.image = UIImage(named: "space.jpg")
            return header
        }
        sectionProxy?.setFooterConfigClosure({ (indexPath, collectionView) in
            //map indexpath.section to reuseIdentifier
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID, for: indexPath) as! CollectionViewFooter
            footer.imageView.image = UIImage(named: "footer.jpg")
            return footer
        })
        collection.dataSource = sectionProxy
        collection.delegate = sectionProxy
    }

    func makeSection1(_ collection: UICollectionView) -> BBQCollectionViewProxy<Any> {
        let proxy = BBQCollectionViewProxy<Any>.init(models: ["3.jpg","4.jpg","8.jpg", "14.jpg"], collectionView: collection, reuseIdentifier: "CollectionViewCell", cellConfigBlock: { (imgname, cell) in
            let cell = cell as! CollectionViewCell
            cell.imagView.image = UIImage(named: imgname as! String)
        })
        proxy.setHeaderSizeClosure { return CGSize(width: 200, height: 200) }
        proxy.setFooterSizeClosure { return CGSize(width: 0.1, height: 0.1) }
        proxy.setCellSizeClosure { (row) in
            if row%2 == 0 {
                return CGSize(width: 160, height: 160)
            }
            return CGSize(width: 100, height: 100)
        }
        return proxy
    }

    func makeSection2(_ collection: UICollectionView) -> BBQCollectionViewProxy<Any> {
        let proxy = BBQCollectionViewProxy<Any>(models: ["1875.JPG","1878.JPG","1879.GIF", "1881.GIF"], collectionView: collection, reuseIdentifier: "CollectionViewCell", cellConfigBlock: { (imgname, cell) in
            let cell = cell as! CollectionViewCell
            cell.imagView.image = UIImage(named: imgname as! String)
        })
        proxy.setFooterSizeClosure { return CGSize(width: Int.random(in: 200...300), height: Int.random(in: 200...300)) }
        proxy.setHeaderSizeClosure { return CGSize(width: 0.1, height: 0.1) }
        proxy.setCellSizeClosure { _ in return CGSize(width: Int.random(in: 100...150), height: Int.random(in: 100...150)) }
        return proxy
    }
}
