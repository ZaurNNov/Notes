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
        super.init(coder: aDecoder)
        loadChecklistItems()

        print("Documents folder is \(documentsDirectory())")
    }

    func loadChecklistItems()
    {
        let path = Notes.dataFilePath(for: myIDsAndStrings.appendingPath)
        if let data = try? Data(contentsOf: path) {
            let unarhiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarhiver.decodeObject(forKey: myIDsAndStrings.saveChecklistItems) as! [ChecklistItem]
            unarhiver.finishDecoding()
        }
    }
    
    //my id for cell, segue, stringValue
    //ID's
    private struct myIDsAndStrings {
        //for cell
        static let checklistItem = "ChecklistItem"
        static let cellLabelTag = 100
        static let cellLabelCheckTag = 101

        //segue id
        static let addItem = "AddItem"
        static let editItem = "EditItem"

        //strings
        static let saveChecklistItems = "ChecklistItems"
        static let appendingPath = "Checklists.plist"
    }


    //for test
    var items: [ChecklistItem]
    var checklist: Checklist!

    //MARK: TableView Life cicle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
    }

    //MARK: TableView Data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: myIDsAndStrings.checklistItem, for: indexPath)

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
        let label = cell.viewWithTag(myIDsAndStrings.cellLabelCheckTag) as! UILabel

        if item.checked {
            label.text = "☑️"
        } else {
            label.text = "  "
        }
    }

    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem)
    {
        let label = cell.viewWithTag(myIDsAndStrings.cellLabelTag) as! UILabel
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
        if segue.identifier == myIDsAndStrings.addItem {
            //Add new Item
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! ItemDetailViewController
            targetController.delegate = self

             //Edit Item
        } else if segue.identifier == myIDsAndStrings.editItem {
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! ItemDetailViewController
            targetController.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                targetController.itemToEdit = items[indexPath.row]
            }
        }
    }

    //MARK: DocumentDirectory save my files
    //serialization
    func saveChecklistItems()
    {
        let data = NSMutableData()
        let arhiver = NSKeyedArchiver(forWritingWith: data)
        arhiver.encode(items, forKey: myIDsAndStrings.saveChecklistItems)
        arhiver.finishEncoding()
        data.write(to: Notes.dataFilePath(for: myIDsAndStrings.appendingPath), atomically: true)
    }


}
