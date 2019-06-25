//
//  BBQCollectionHeaderFooterView.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/25.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public let DefaultHeaderID = "BBQHeader"
public let DefaultFooterID = "BBQFooter"

public class BBQCollectionHeaderFooterView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
