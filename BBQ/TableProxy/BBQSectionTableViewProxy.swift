//
//  BBQSectionTableDataSource.swift
//  BBQKit
//
//  Created by qzjian on 2019/6/20.
//  Copyright © 2019 qzjian. All rights reserved.
//

import UIKit

public class BBQSectionTableViewProxy: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var tableProxys: [BBQTableViewProxy<Any>]
    private var firstCellExpandable = false
    private var isExpandings: [Bool] = []

    // MARK: - configs

    /// config whether first row of cell can expand subcells
    public func setFirstCellExpandable(_ expandable: Bool) {
        self.firstCellExpandable = expandable
    }

    public init(tableProxys: [BBQTableViewProxy<Any>]) {
        self.tableProxys = tableProxys
        isExpandings = [Bool](repeating: false, count: tableProxys.count)
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableProxys.count
    }

    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let proxy = tableProxys[section]
        if self.firstCellExpandable {
            let isExpand = isExpandings[section]
            return isExpand ? proxy.models.count : 1
        }
        return proxy.tableView(tableView, numberOfRowsInSection: 0)
    }

    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let proxy = tableProxys[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return proxy.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension BBQSectionTableViewProxy {

    // Editing
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let proxy = tableProxys[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return proxy.tableView(tableView, canEditRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            var tmptableProxys = tableProxys
            let dataSource = tmptableProxys[indexPath.section]
            dataSource.remove(at: indexPath.row)
            tmptableProxys[indexPath.section] = dataSource
            tableProxys = tmptableProxys
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let proxy = tableProxys[indexPath.section]
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        return proxy.tableView(tableView, canMoveRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let srcProxy = tableProxys[sourceIndexPath.section]
        let dstProxy = tableProxys[destinationIndexPath.section]
        if sourceIndexPath.section == destinationIndexPath.section {
            srcProxy.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
            tableProxys[sourceIndexPath.section] = srcProxy
            return 
        }

        guard let model = srcProxy.model(at: sourceIndexPath.row) else { return }

        srcProxy.remove(at: sourceIndexPath.row)
        tableProxys[sourceIndexPath.section] = srcProxy

        dstProxy.insert(model, at: destinationIndexPath.row)
        tableProxys[destinationIndexPath.section] = dstProxy
        tableView.reloadData()
    }

    // MARK: - config header and footer
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let proxy = tableProxys[section]
        return proxy.tableView(tableView, viewForHeaderInSection: 0)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let proxy = tableProxys[section]
        return proxy.tableView(tableView, viewForFooterInSection: 0)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let proxy = tableProxys[section]
        return proxy.tableView(tableView, heightForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let proxy = tableProxys[section]
        return proxy.tableView(tableView, heightForFooterInSection: section)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let proxy = tableProxys[indexPath.section]
        if self.firstCellExpandable && indexPath.row == 0 {
            let sec = indexPath.section
            var ips = [IndexPath]()
            for i in 1..<proxy.models.count {
                ips.append(IndexPath(row: i, section: sec))
            }
            if !isExpandings[sec] {
                isExpandings[sec] = true
                tableView.beginUpdates()
                tableView.insertRows(at: ips, with: .automatic)
                tableView.endUpdates()
            }
            else {
                isExpandings[sec] = false
                tableView.beginUpdates()
                tableView.deleteRows(at: ips, with: .automatic)
                tableView.endUpdates()
            }
            return
        }
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        proxy.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: tableView.indexPathForSelectedRow ?? indexPath, animated: true)
    }
}
