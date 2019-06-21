//
//  BBQTableDataSource.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/20.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public class BBQTableViewProxy<Model>: NSObject, UITableViewDataSource, UITableViewDelegate {

    typealias CellConfigClosure = (Model, UITableViewCell) -> Void
    public typealias HeaderFooterConfigClosure = () -> UIView
    public typealias HeaderFooterHeightConfigClosure = () -> CGFloat
    public typealias CellHeightConfigClosure = (Int) -> CGFloat

    public typealias CellMoveConfigClosure = (Int) -> Bool
    public typealias CellEditConfigClosure = (Int) -> Bool

    public typealias CellClickClosure = (Model) -> Void

    var models: [Model] = []

    private var reuseIdentifier: String = ""
    private let cellConfigBlock: CellConfigClosure
    private var cellHightConfigBlock: CellHeightConfigClosure?
    private var cellClickClosure: CellClickClosure?

    private var cellMoveConfigBlock: CellMoveConfigClosure = { (row) in return true }
    private var cellEditConfigClosure: CellEditConfigClosure = { (row) in return true }

    private var headerReuseIdentifier: String?
    private var headerConfigClosure: HeaderFooterConfigClosure?
    private var headerHeightClosure: HeaderFooterHeightConfigClosure?

    private var footerReuseIdentifier: String?
    private var footerConfigClosure: HeaderFooterConfigClosure?
    private var footerHeightClosure: HeaderFooterHeightConfigClosure?

    //MARK: - datasource operatorion
    public func remove(at index: Int) {
        guard models.count > index else { return }
        models.remove(at: index)
    }

    public func insert(_ model: Model, at index: Int) {
        guard models.count >= index else { return }
        models.insert(model, at: index)
    }

    public func update(_ model: Model, at index: Int) {
        guard models.count > index else { return }
        models[index] = model
    }

    public func model(at index: Int) -> Model? {
        guard models.count > index else { return nil }
        return models[index]
    }

    public func modelsCount() -> Int { return models.count }

    //MARK: - init

    /// congfig basic tableview with specific models and cell config closure
    ///
    /// - Parameters:
    ///   - models: models to config tableview cells
    ///   - reuseIdentifier: reuseIdentifier to deuque a tableviewcell
    ///   - cellConfigBlock: block to config a cell with associated model
    init(models: [Model], reuseIdentifier: String, cellConfigBlock: @escaping CellConfigClosure) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigBlock = cellConfigBlock
    }

    // MARK: - configs

    /// config whether specific row of cell can move
    ///
    /// - Parameter closure: closure to config whether specific row of cell can move
    public func setCellMoveConfigBlock(_ closure: @escaping CellMoveConfigClosure) {
        self.cellMoveConfigBlock = closure
    }

    /// config whether specific row of cell can edit
    ///
    /// - Parameter closure: closure to config whether specific row of cell can edit
    public func setCellEditConfigBlock(_ closure: @escaping CellEditConfigClosure) {
        self.cellEditConfigClosure = closure
    }

    /// config cell click callback
    ///
    /// - Parameter closure: closure to execute when cell clicked
    public func setCellClickBlock(_ closure: @escaping CellClickClosure) {
        self.cellClickClosure = closure
    }

    /// config tableview header
    ///
    /// - Parameters:
    ///   - resuseId: the reusedIdentifier for dequeue header view
    ///   - closure: closure for config header contenview
    public func setHeaderConfig(_ resuseId: String, _ closure: @escaping HeaderFooterConfigClosure) {
        self.headerReuseIdentifier = resuseId
        self.headerConfigClosure = closure
    }

    /// config tableview footer
    ///
    /// - Parameters:
    ///   - resuseId: the reusedIdentifier for dequeue footer view
    ///   - closure: closure for config footer contenview
    public func setFooterConfig(_ resuseId: String, _ closure: @escaping HeaderFooterConfigClosure) {
        self.footerReuseIdentifier = resuseId
        self.footerConfigClosure = closure
    }

    /// config tableview cell height in specific row
    ///
    /// - Parameter closure: closure for config one cell height
    public func setCellHeightConfig(_ closure: @escaping CellHeightConfigClosure) {
        self.cellHightConfigBlock = closure
    }

    /// config tableview header height
    ///
    /// - Parameter closure: the closure for config the header height
    public func setHeaderHeightConfig(_ closure: @escaping HeaderFooterHeightConfigClosure) {
        self.headerHeightClosure = closure
    }

    /// config tableview footer height
    ///
    /// - Parameter closure: the closure for config the footer heigh
    public func setFooterHeightConfig(_ closure: @escaping HeaderFooterHeightConfigClosure) {
        self.footerHeightClosure = closure
    }

    // MARK: - tableview datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigBlock(model, cell)
        return cell
    }

    // Editing
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.cellEditConfigClosure(indexPath.row)
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.cellMoveConfigBlock(indexPath.row)
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    // Data manipulation - reorder / moving support
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tmpModels = models
        tmpModels.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        models = tmpModels

        tableView.reloadData()
    }

    // MARK: - tableview delegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHightConfigBlock?(indexPath.row) ?? 44
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard models.count > 0 else { return 0 }
        return self.headerHeightClosure?() ?? 0
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard models.count > 0 else { return 0 }
        return self.footerHeightClosure?() ?? 0
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click: \(indexPath.row), models: \(models)")
        let model = models[indexPath.row]
        self.cellClickClosure?(model)
        tableView.deselectRow(at: tableView.indexPathForSelectedRow ?? indexPath, animated: true)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier ?? "")
        let contentView = self.headerConfigClosure?() ?? UIView()
        header?.backgroundView = contentView
        return header
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerReuseIdentifier ?? "")
        let contentView = self.footerConfigClosure?() ?? UIView()
        footer?.backgroundView = contentView
        return footer
    }
}
