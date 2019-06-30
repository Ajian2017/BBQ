//
//  CollectionViewFooter.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/25.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

class CollectionViewFooter: UICollectionReusableView {
    let imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        imageView.bbq()!.leading().trailing().top().bottom()
    }
}
