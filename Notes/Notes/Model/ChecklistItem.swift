//
//  ChecklistItem.swift
//  Notes
//
//  Created by ZaurNNov on 03.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import Foundation

//Model
class ChecklistItem {
    var text = ""
    var checked = false

    func toggleChecked() {
        checked = !checked
    }
}


