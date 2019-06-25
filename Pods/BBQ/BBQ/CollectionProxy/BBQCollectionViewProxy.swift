//
//  BBQCollectionViewProxy.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/24.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public class BBQCollectionViewProxy<Model>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    public typealias CollectionCellConfigClosure = (Model, UICollectionViewCell) -> Void
    public typealias CollectionCellClickClosure = (Model) -> Void
    public typealias HeaderFooterViewConfigClosure = (UICollectionView, IndexPath) -> UICollectionReusableView

    var models: [Model] = []

    private var reuseIdentifier: String = ""
    private let cellConfigBlock: CollectionCellConfigClosure
    private var cellClickClosure: CollectionCellClickClosure?

    private var headerConfigClosure: HeaderFooterViewConfigClosure?
    private var footerConfigClosure: HeaderFooterViewConfigClosure?

    //MARK: - init

    /// congfig basic collectionview with specific models and cell config closure
    ///
    /// - Parameters:
    ///   - models: models to config tableview cells
    ///   - reuseIdentifier: reuseIdentifier to deuque a tableviewcell
    ///   - cellConfigBlock: block to config a cell with associated model
    public init(models: [Model], reuseIdentifier: String, cellConfigBlock: @escaping CollectionCellConfigClosure) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigBlock = cellConfigBlock
    }

    /// config cell click callback
    ///
    /// - Parameter closure: closure to execute when cell clicked
    public func setCellClickBlock(_ closure: @escaping CollectionCellClickClosure) {
        self.cellClickClosure = closure
    }

    /// config collection header closure
    ///
    /// - Parameter closure: closure to config collection header
    public func setHeaderConfigClosure(_ closure: @escaping HeaderFooterViewConfigClosure) {
        self.headerConfigClosure = closure
    }

    /// config collection footer closure
    ///
    /// - Parameter closure: closure to config collection header
    public func setFooterConfigClosure(_ closure: @escaping HeaderFooterViewConfigClosure) {
        self.footerConfigClosure = closure
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cellConfigBlock(model, cell)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return self.headerConfigClosure?(collectionView, indexPath) ?? UICollectionReusableView(frame: .zero)
        case UICollectionView.elementKindSectionFooter:
            return self.footerConfigClosure?(collectionView, indexPath) ?? UICollectionReusableView(frame: .zero)
        default:
            return UICollectionReusableView(frame: .zero)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        self.cellClickClosure?(model)
    }

}


public extension UICollectionViewFlowLayout {
    
    @discardableResult
    func cellSize(_ width: CGFloat, _ height: CGFloat) -> UICollectionViewFlowLayout {
        self.itemSize = CGSize(width: width, height: height)
        return self
    }

    @discardableResult
    func headerSize(_ width: CGFloat, _ height: CGFloat) -> UICollectionViewFlowLayout {
        self.headerReferenceSize = CGSize(width: width, height: height)
        return self
    }

    @discardableResult
    func footerSize(_ width: CGFloat, _ height: CGFloat) -> UICollectionViewFlowLayout {
        self.footerReferenceSize = CGSize(width: width, height: height)
        return self
    }

    @discardableResult
    func lineSpace(_ space: CGFloat) -> UICollectionViewFlowLayout {
        self.minimumLineSpacing = space
        return self
    }

    @discardableResult
    func interSpace(_ space: CGFloat) -> UICollectionViewFlowLayout {
        self.minimumInteritemSpacing = space
        return self
    }
}
