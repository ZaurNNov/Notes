//
//  AllListsViewController.swift
//  Notes
//
//  Created by ZaurNNov on 18.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {

    //hints
    //if remove the numberOfSections(in) method, will always be a single section in the table view.

    //Model
    var lists: [Checklist]
    
    //load data
    func loadData ()
    {
        let path = dataFilePath(for: myStrings.appendingPath)
        
        if let data = try? Data(contentsOf: path) {
            let unarhiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarhiver.decodeObject(forKey: myStrings.saveChecklistItems) as! [Checklist]
            unarhiver.finishDecoding()
        }
    }

    //inits
    required init?(coder aDecoder: NSCoder) {
        lists = [Checklist]()

        super.init(coder: aDecoder)
        saveData(whatNeedsToBeKept: lists)
        //exaples
        /*
        for list in lists {
            let item = ChecklistItem()
            item.text = "Checklist item \(item)"
            list.items.append(item)
        }
         */
    }

    // MARK: - Table view data source and delegate
    //hows need cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    //make cell
    func makeCell(for tableView: UITableView) -> UITableViewCell
    {
        let cellId = myStrings.cellId
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
    }
    //data in cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //data
        let checklist = lists[indexPath.row]

        let cell = makeCell(for: tableView)

        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton

        return cell
    }
    //delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let naviController = storyboard!.instantiateViewController(withIdentifier: myStrings.listDetailNaviController) as! UINavigationController
        let controller = naviController.topViewController as! ListDetailViewController
        controller.delegate = self

        let checklist = lists[indexPath.row]
        controller.checklistToEdit = checklist
        present(naviController, animated: true, completion: nil)
    }


    //MARK: Segues
    //segue = "ShowChecklist" (to ChecklistViewController)
    //segue = "AddChecklist" (to ListDetailViewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == myStrings.showChecklist {
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == myStrings.addChecklist {
            let naviController = segue.destination as! UINavigationController
            let controller = naviController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: myStrings.showChecklist, sender: checklist)
    }


    //delegate - listen ListDetailViewController
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    {
        dismiss(animated: true, completion: nil)
    }

    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    {
        let newRowIndex = lists.count
        lists.append(checklist)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }

    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
    {
        if let index = lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }

}

