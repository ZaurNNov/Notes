//
//  ChecklistViewController.swift
//  Notes
//
//  Created by Zaur Giyasov on 26/10/2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

//Controller
class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

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
        print("Documents folder is \(documentsDirectory())")
    }
    
    //my id for cell and segue
    //ID's
    private struct variableIdentifiers {
        //for cell
        static let checklistItem = "ChecklistItem"
        static let cellLabelTag = 100
        static let cellLabelCheckTag = 101

        //segue id
        static let addItem = "AddItem"
        static let editItem = "EditItem"
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
        //save in folder
        saveChecklistItems()
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem)
    {
        let label = cell.viewWithTag(variableIdentifiers.cellLabelCheckTag) as! UILabel

        if item.checked {
            label.text = "☑️"
        } else {
            label.text = "  "
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
        //save in folder
        saveChecklistItems()
    }

    //MARK: Delegates: hand-in-hund with protocols
    //AddItemViewControllerDelegate funcs
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    {
        dismiss(animated: true, completion: nil)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishingAdding item: ChecklistItem)
    {
        let newRowIndex = items.count
        items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        dismiss(animated: true, completion: nil)
        //save in folder
        saveChecklistItems()
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
    {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        //save in folder
        saveChecklistItems()
    }

    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //Delegate: ItemDetailViewController
        if segue.identifier == variableIdentifiers.addItem {
            //Add new Item
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! ItemDetailViewController
            targetController.delegate = self

             //Edit Item
        } else if segue.identifier == variableIdentifiers.editItem {
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! ItemDetailViewController
            targetController.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                targetController.itemToEdit = items[indexPath.row]
            }
        }
    }

    //MARK: DocumentDirectory save my files
    func documentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //link in this app-home folder
        return paths[0]
    }

    func dataFilePath() -> URL
    {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }

    //serialization
    func saveChecklistItems()
    {
        let data = NSMutableData()
        let arhiver = NSKeyedArchiver(forWritingWith: data)
        arhiver.encode(items, forKey: "ChecklistItems")
        arhiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }


}
