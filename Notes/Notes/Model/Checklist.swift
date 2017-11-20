//
//  Checklist.swift
//  Notes
//
//  Created by ZaurNNov on 18.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {

    var name = myStrings.empty
    var items = [ChecklistItem]()

    //autocreate instance with var string
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: myStrings.forKeyName) as! String
        items = aDecoder.decodeObject(forKey: myStrings.forKeyItems) as! [ChecklistItem]
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: myStrings.forKeyName)
        aCoder.encode(items, forKey: myStrings.forKeyItems)
    }

}

