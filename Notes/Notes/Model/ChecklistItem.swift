//
//  ChecklistItem.swift
//  Notes
//
//  Created by ZaurNNov on 03.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import Foundation

//Model
class ChecklistItem: NSObject, NSCoding {

    //my stringValue
    private struct myStrings {
        //strings
        static let text = "Text"
        static let checked = "Checked"
        static let empty = ""
    }

    var text = myStrings.empty
    var checked = false

    func toggleChecked() {
        checked = !checked
    }

    //Coding - Decoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: myStrings.text)
        aCoder.encode(checked, forKey: myStrings.checked)
    }

    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: myStrings.text) as! String
        checked = aDecoder.decodeBool(forKey: myStrings.checked)
        super.init()
    }

    override init() {
        super.init()
    }
}


