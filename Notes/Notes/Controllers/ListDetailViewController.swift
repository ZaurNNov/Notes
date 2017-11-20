//
//  ListDetailViewController.swift
//  Notes
//
//  Created by ZaurNNov on 18.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

//MARK: Delegates: hand-in-hund with protocols
protocol ListDetailViewControllerDelegate: class
{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

    //Delegate for broadcasting selfchange
    weak var delegate: ListDetailViewControllerDelegate?

    //Data
    var checklistToEdit: Checklist?

    //IB elements and Actions
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBAction func cancel()
    {
        delegate?.listDetailViewControllerDidCancel(self)
    }

    @IBAction func done()
    {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            delegate?.listDetailViewController(self, didFinishAdding: checklist)
        }
    }

    //MARK: TableView Life cicle methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let checklist = checklistToEdit {
            title = myStrings.editItem
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    //MARK: UITextFieldDelegate funcs
    //if text field empty - hide Done buttom
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        hideDoneButtonIfTextEmpty(textField: textField, range: range, string: string, barButton: doneBarButton)
        
        return true
    }

}


