//
//  myCustomMethods.swift
//  Notes
//
//  Created by ZaurNNov on 18.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

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



