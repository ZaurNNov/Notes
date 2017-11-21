//
//  myCustomMethods.swift
//  Notes
//
//  Created by ZaurNNov on 18.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

//my id for cell, segue, stringValue
//ID's
struct myStrings {
    //for cell
    static let checklistItem = "ChecklistItem"
    static let cellLabelTag = 100
    static let cellLabelCheckTag = 101
    static let cellId = "Cell"
    
    //segue id
    static let addItem = "AddItem"
    static let editItem = "EditItem"
    static let showChecklist = "ShowChecklist"
    static let addChecklist = "AddChecklist"
    
    //strings
    static let saveChecklistItems = "ChecklistItems"
    static let appendingPath = "Checklists.plist"
    static let title = "Edit Checklist"
    static let text = "Text"
    static let checked = "Checked"
    static let checkedEmoji = "☑️"
    static let documentsFolderIs = "Documents folder is "
    
    //Navigation Controllers
    static let listDetailNaviController = "ListDetailNaviController"
    
    //Coder & Encoder
    static let forKeyName = "Name"
    static let forKeyItems = "Items"
    static let empty = ""
    static let empty2Speces = "  "
}

//if text field empty - hide Done buttom
func hideDoneButtonIfTextEmpty(textField: UITextField, range: NSRange, string: String, barButton: UIBarButtonItem) {
    let oldText = textField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    barButton.isEnabled = (newText.length > 0)
}

//MARK: DocumentDirectory save my files
//*************************************
func documentsDirectory() -> URL
{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //link in this app-home folder
    return paths[0]
}
func dataFilePath(for pathComponent: String) -> URL
{
    return documentsDirectory().appendingPathComponent(pathComponent)
}
//*************************************
//save files
func saveData (whatNeedsToBeKept thisSave: [Checklist])
{
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    
    archiver.encode(thisSave, forKey: myStrings.saveChecklistItems)
    archiver.finishEncoding()
    data.write(to: dataFilePath(for: myStrings.appendingPath), atomically: true)
    print("saveData")
}

//for global file (AppDelegate.swift)
func saveDataFromViews(_ window: UIWindow?) {
    let navigationController = window!.rootViewController
        as! UINavigationController
    let controller = navigationController.viewControllers[0] as! AllListsViewController
    saveData(whatNeedsToBeKept: controller.dataModel.lists)
    print("saveDataFromViews")
}




