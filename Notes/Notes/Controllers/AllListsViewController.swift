//
//  AllListsViewController.swift
//  Notes
//
//  Created by ZaurNNov on 18.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {

    //hints
    //if remove the numberOfSections(in) method, will always be a single section in the table view.

    //Model
    var dataModel: DataModel!

    // MARK: - Table view data source and delegate
    //hows need cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
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
        let checklist = dataModel.lists[indexPath.row]

        let cell = makeCell(for: tableView)

        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton

        return cell
    }
    //delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let naviController = storyboard!.instantiateViewController(withIdentifier: myStrings.listDetailNaviController) as! UINavigationController
        let controller = naviController.topViewController as! ListDetailViewController
        controller.delegate = self

        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        present(naviController, animated: true, completion: nil)
    }

    //MARK: TableView Life cicle methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: myStrings.showChecklist, sender: checklist)
        }
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
        dataModel.indexOfSelectedChecklist = indexPath.row
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: myStrings.showChecklist, sender: checklist)
    }
    //delegate NaviController
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //was buck button tapped?
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }

    //delegate - listen ListDetailViewController
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    {
        dismiss(animated: true, completion: nil)
    }

    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }

    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
    {
        if let index = dataModel.lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }


}



