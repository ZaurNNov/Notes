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
    //for test
    //var items: [ChecklistItem]
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
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: myStrings.checklistItem, for: indexPath)

        //test
        let item = checklist.items[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }

    // select rows
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem)
    {
        let label = cell.viewWithTag(myStrings.cellLabelCheckTag) as! UILabel

        if item.checked {
            label.text = myStrings.checkedEmoji
        } else {
            label.text = myStrings.empty2Speces
        }
    }

    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem)
    {
        let label = cell.viewWithTag(myStrings.cellLabelTag) as! UILabel
        label.text = item.text
    }

    //MARK: Actions
    //delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        checklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    //MARK: Delegates: hand-in-hund with protocols
    //AddItemViewControllerDelegate funcs
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    {
        dismiss(animated: true, completion: nil)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishingAdding item: ChecklistItem)
    {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        dismiss(animated: true, completion: nil)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
    {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
    }

    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //Delegate: ItemDetailViewController
        if segue.identifier == myStrings.addItem {
            //Add new Item
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! ItemDetailViewController
            targetController.delegate = self
             //Edit Item
        } else if segue.identifier == myStrings.editItem {
            let naviController = segue.destination as! UINavigationController
            let targetController = naviController.topViewController as! ItemDetailViewController
            targetController.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                targetController.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }

}
