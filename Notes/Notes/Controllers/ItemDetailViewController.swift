//
//  ItemDetailViewController.swift
//  Notes
//
//  Created by ZaurNNov on 04.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    //Controller for Add Item scene
    //(This View create new Item(note)

    //MARK: Action and IB elements
    @IBAction func cancel()
    {
        delegate?.itemDetailViewControllerDidCancel(self)
    }

    @IBAction func done()
    {
        //create or edit item and add text
        //edit item
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)

        } else {
        //create new item
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishingAdding: item)
        }
    }

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    

    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    //MARK: TableView Life cicle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
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
protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishingAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}
