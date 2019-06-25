//
//  BBQSectionCollectionViewProxy.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/25.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public class BBQSectionCollectionViewProxy: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public typealias ReusableViewConfigClosure = (IndexPath, UICollectionView) -> UICollectionReusableView

    private var collectionProxys: [BBQCollectionViewProxy<Any>]
    private var headerConfigClosure: ReusableViewConfigClosure?
    private var footerConfigClosure: ReusableViewConfigClosure?

    private var defaultFooterConfigClosure: HeaderFooterViewConfigClosure = {
        (indexPath, collectionView) in
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DefaultFooterID, for: indexPath) as! CollectionHeaderFooterView
        return footer
    }

    private var defaultHeaderConfigClosure: HeaderFooterViewConfigClosure = {
        (indexPath, collectionView) in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DefaultHeaderID, for: indexPath) as! CollectionHeaderFooterView
        return header
    }

    //MARK: - init
    public init(collectionProxys: [BBQCollectionViewProxy<Any>]) {
        self.collectionProxys = collectionProxys
    }

    public func setHeaderConfigClosure(_ closure: @escaping ReusableViewConfigClosure) {
        self.headerConfigClosure = closure
    }

    public func setFooterConfigClosure(_ closure: @escaping ReusableViewConfigClosure) {
        self.footerConfigClosure = closure
    }

    //MARK: - datasource & delegate
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionProxys.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let proxy = collectionProxys[section]
        return proxy.collectionView(collectionView, numberOfItemsInSection: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let proxy = collectionProxys[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return proxy.collectionView(collectionView, cellForItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let closure = self.headerConfigClosure ?? defaultHeaderConfigClosure
            return closure(indexPath, collectionView)
        }
        else {
            let closure = self.footerConfigClosure ?? defaultFooterConfigClosure
            return closure(indexPath, collectionView)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let proxy = collectionProxys[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        proxy.collectionView(collectionView, didSelectItemAt: indexPath)
    }

    //MARK: - flowLayout delegate
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let proxy = collectionProxys[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return proxy.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let proxy = collectionProxys[section]
        return proxy.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let proxy = collectionProxys[section]
        return proxy.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let proxy = collectionProxys[section]
        return proxy.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let proxy = collectionProxys[section]
        return proxy.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let proxy = collectionProxys[section]
        return proxy.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: 0)
    }
}
