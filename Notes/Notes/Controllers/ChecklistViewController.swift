//
//  ChecklistViewController.swift
//  Notes
//
//  Created by Zaur Giyasov on 26/10/2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

//Controller
class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {

    //Local model
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()

        let row0text = ChecklistItem()
        row0text.text = "row0text.text"
        row0text.checked = false
        items.append(row0text)

        let row1text = ChecklistItem()
        row1text.text = "row1text.text"
        row1text.checked = true
        items.append(row1text)

        let row2text = ChecklistItem()
        row2text.text = "row2text.text"
        row2text.checked = false
        items.append(row2text)

        let row3text = ChecklistItem()
        row3text.text = "row3text.text"
        row3text.checked = true
        items.append(row3text)

        let row4text = ChecklistItem()
        row4text.text = "row4text.text"
        row4text.checked = false
        items.append(row4text)

        super.init(coder: aDecoder)
    }
    
    //my id for cell and segue
    //ID's
    private struct variableIdentifiers {
        //for cell
        static let checklistItem = "ChecklistItem"
        static let cellLabelTag = 100

        //segue id
        static let addItem = "AddItem"
    }


    //for test
    var items: [ChecklistItem]

    //MARK: TableView Data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: variableIdentifiers.checklistItem, for: indexPath)

        //test
        let item = items[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }

    // select rows
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem)
    {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem)
    {
        let label = cell.viewWithTag(variableIdentifiers.cellLabelTag) as! UILabel
        label.text = item.text
    }

    //MARK: Actions
    //delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    //MARK: Delegates: hand-in-hund with protocols
    //AddItemViewControllerDelegate funcs
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    {
        dismiss(animated: true, completion: nil)
    }

    func addItemViewController(_ controller: AddItemViewController, didFinishingAdding item: ChecklistItem)
    {
        let newRowIndex = items.count
        items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        dismiss(animated: true, completion: nil)
    }

    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Delegate: AddItemViewController
        if segue.identifier == variableIdentifiers.addItem {
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! AddItemViewController
            targetController.delegate = self
        }
    }


}
