//
//  BBQSectionTableDataSource.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/20.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public class BBQSectionTableViewProxy: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var dataSources: [BBQTableViewProxy<Any>]

    init(dataSources: [BBQTableViewProxy<Any>]) {
        self.dataSources = dataSources
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }

    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, numberOfRowsInSection: 0)
    }

    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = dataSources[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension BBQSectionTableViewProxy {

    // Editing
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let dataSource = dataSources[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return dataSource.tableView(tableView, canEditRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            var tmpDataSources = dataSources
            let dataSource = tmpDataSources[indexPath.section]
            dataSource.remove(at: indexPath.row)
            tmpDataSources[indexPath.section] = dataSource
            dataSources = tmpDataSources
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let dataSource = dataSources[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return dataSource.tableView(tableView, canMoveRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let srcDataSource = dataSources[sourceIndexPath.section]
        let dstDataSource = dataSources[destinationIndexPath.section]
        if sourceIndexPath.section == destinationIndexPath.section {
            srcDataSource.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
            dataSources[sourceIndexPath.section] = srcDataSource
            return 
        }

        guard let model = srcDataSource.model(at: sourceIndexPath.row) else { return }

        srcDataSource.remove(at: sourceIndexPath.row)
        dataSources[sourceIndexPath.section] = srcDataSource

        dstDataSource.insert(model, at: destinationIndexPath.row)
        dataSources[destinationIndexPath.section] = dstDataSource
        tableView.reloadData()
    }

    // MARK: - config header and footer
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, viewForHeaderInSection: 0)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, viewForFooterInSection: 0)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, heightForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let dataSource = dataSources[section]
        return dataSource.tableView(tableView, heightForFooterInSection: section)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSource = dataSources[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        dataSource.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: tableView.indexPathForSelectedRow ?? indexPath, animated: true)
    }
}
