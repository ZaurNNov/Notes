//
//  AddItemViewController.swift
//  Notes
//
//  Created by ZaurNNov on 04.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    //Controller for Add Item scene
    //(This View create new Item(note)

    //MARK: Action and IB elements
    @IBAction func cancel()
    {
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func done()
    {
        //create item and add text
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        //send instanse for delegate
        delegate?.addItemViewController(self, didFinishingAdding: item)
    }

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: AddItemViewControllerDelegate?

    

    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    //MARK: TableView Life cicle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    //MARK: UITextFieldDelegate funcs
    //if text field empty - hide Done buttom
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0)

        return true
    }

    
    
}

//MARK: Delegates: hand-in-hund with protocols
protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishingAdding item: ChecklistItem)
}
