//
//  ChecklistViewController.swift
//  Notes
//
//  Created by Zaur Giyasov on 26/10/2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

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
    let checklistItem = "ChecklistItem"
    let cellLabelTag = 100


    //for test
    var items: [ChecklistItem]

//    var row0text: ChecklistItem
//    var row1text: ChecklistItem
//    var row2text: ChecklistItem
//    var row3text: ChecklistItem
//    var row4text: ChecklistItem


    //MARK: TableView Data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: checklistItem, for: indexPath)

        //test
        let item = items[indexPath.row]
        let label = cell.viewWithTag(cellLabelTag) as! UILabel
        label.text = item.text

        configureCheckmark(for: cell, at: indexPath)
        return cell
    }

    // select rows
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.checked = !item.checked

            configureCheckmark(for: cell, at: indexPath)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath)
    {
        let item = items[indexPath.row]

        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

}

