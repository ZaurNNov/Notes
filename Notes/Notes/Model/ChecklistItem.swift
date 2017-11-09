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
    var text = ""
    var checked = false

    func toggleChecked() {
        checked = !checked
    }

    //Coding - Decoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
    }

    override init() {
        super.init()
    }
}


