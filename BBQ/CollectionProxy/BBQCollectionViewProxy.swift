//
//  BBQCollectionViewProxy.swift
//  BBQKitDemo
//
//  Created by qzjian on 2019/6/24.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public class BBQCollectionViewProxy<Model>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public typealias HeaderFooterViewConfigClosure = (IndexPath, UICollectionView) -> UICollectionReusableView

    public typealias CollectionCellConfigClosure = (Model, UICollectionViewCell) -> Void
    public typealias CollectionCellClickClosure = (Model) -> Void

    public typealias CellSizeConfigClosure = (Int) -> CGSize
    public typealias HeaderFooterSizeConfigClosure = () -> CGSize
    public typealias SpacingConfigClosure = () -> CGFloat
    public typealias InsetsConfigClosure = () -> UIEdgeInsets

    var models: [Model] = []

    private weak var collectionView: UICollectionView?

    private var reuseIdentifier: String = ""
    private let cellConfigBlock: CollectionCellConfigClosure
    private var cellClickClosure: CollectionCellClickClosure?

    private var headerConfigClosure: HeaderFooterViewConfigClosure?
    private var footerConfigClosure: HeaderFooterViewConfigClosure?
    
    public var defaultFooterConfigClosure: HeaderFooterViewConfigClosure = {
        (indexPath, collectionView) in
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DefaultFooterID, for: indexPath) as! CollectionHeaderFooterView
        return footer
    }

    public var defaultHeaderConfigClosure: HeaderFooterViewConfigClosure = {
        (indexPath, collectionView) in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DefaultHeaderID, for: indexPath) as! CollectionHeaderFooterView
        return header
    }

    private var cellSizeConfigClosure: CellSizeConfigClosure?
    private var headerSizeConfigClosure: HeaderFooterSizeConfigClosure?
    private var footerSizeConfigClosure: HeaderFooterSizeConfigClosure?

    private var lineSpaceConfigClosure: SpacingConfigClosure?
    private var interSpaceConfigClosure: SpacingConfigClosure?

    private var insetsConfigClosure: InsetsConfigClosure?

    //MARK: - init

    /// congfig basic collectionview with specific models and cell config closure
    ///
    /// - Parameters:
    ///   - models: models to config tableview cells
    ///   - reuseIdentifier: reuseIdentifier to deuque a tableviewcell
    ///   - cellConfigBlock: block to config a cell with associated model
    public init(models: [Model], collectionView: UICollectionView, reuseIdentifier: String, cellConfigBlock: @escaping CollectionCellConfigClosure) {
        self.collectionView = collectionView
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigBlock = cellConfigBlock

        collectionView.register(CollectionHeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DefaultHeaderID)
        collectionView.register(CollectionHeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DefaultFooterID)
    }

    //MARK: - configs

    /// config cell click callback
    ///
    /// - Parameter closure: closure to execute when cell clicked
    public func setCellClickBlock(_ closure: @escaping CollectionCellClickClosure) {
        self.cellClickClosure = closure
    }

    /// config collection header
    ///
    /// - Parameters:
    ///   - resuseId: the reusedIdentifier for dequeue header view
    ///   - closure: closure for config header view
    public func setHeaderConfig(_ closure: @escaping HeaderFooterViewConfigClosure) {
        self.headerConfigClosure = closure
    }

    /// config collection footer
    ///
    /// - Parameters:
    ///   - resuseId: the reusedIdentifier for dequeue footer view
    ///   - closure: closure for config footer view
    public func setFooterConfig(_ closure: @escaping HeaderFooterViewConfigClosure) {
        self.footerConfigClosure = closure
    }

    /// config collection cell size
    ///
    /// - Parameter closure: the closure for config the cell size
    public func setCellSizeClosure(_ closure: @escaping CellSizeConfigClosure) {
        self.cellSizeConfigClosure = closure
    }

    /// config collection header size
    ///
    /// - Parameter closure: the closure for config the header size
    public func setHeaderSizeClosure(_ closure: @escaping HeaderFooterSizeConfigClosure) {
        self.headerSizeConfigClosure = closure
    }

    /// config collection footer size
    ///
    /// - Parameter closure: the closure for config the header size
    public func setFooterSizeClosure(_ closure: @escaping HeaderFooterSizeConfigClosure) {
        self.footerSizeConfigClosure = closure
    }

    /// config collection line spacing
    ///
    /// - Parameter closure: the closure for config collection line spacing
    public func setLineSpaceClosure(_ closure: @escaping SpacingConfigClosure) {
        self.lineSpaceConfigClosure = closure
    }

    /// config collection inter spacing
    ///
    /// - Parameter closure: the closure for config collection inter spacing
    public func setInterSpaceClosure(_ closure: @escaping SpacingConfigClosure) {
        self.interSpaceConfigClosure = closure
    }

    /// config collection EdgeInsets
    ///
    /// - Parameter closure: the closure for config the header height
    public func setInsetsClosure(_ closure: @escaping InsetsConfigClosure) {
        self.insetsConfigClosure = closure
    }

    //MARK: - datasource & delegate

    public func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

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
        if kind == UICollectionView.elementKindSectionHeader {
            let closure = self.headerConfigClosure ?? self.defaultHeaderConfigClosure
            return closure(indexPath, collectionView)
        } else {
            let closure = self.footerConfigClosure ?? self.defaultFooterConfigClosure
            return closure(indexPath, collectionView)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        self.cellClickClosure?(model)
    }

    //MARK: - flowLayout delegate
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let closure = self.cellSizeConfigClosure {
            return closure(indexPath.row)
        }
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return layout.itemSize
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let closure = self.insetsConfigClosure {
            return closure()
        }
        return .zero
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let closure = self.lineSpaceConfigClosure {
            return closure()
        }
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return layout.minimumLineSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let closure = self.interSpaceConfigClosure {
            return closure()
        }
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return layout.minimumInteritemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let closure = self.headerSizeConfigClosure {
            return closure()
        }
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return layout.headerReferenceSize
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let closure = self.footerSizeConfigClosure {
            return closure()
        }
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return layout.footerReferenceSize
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
