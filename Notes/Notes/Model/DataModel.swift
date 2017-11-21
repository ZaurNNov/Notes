//
//  DataModel.swift
//  Notes
//
//  Created by ZaurNNov on 21.11.2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()

    //load data
    func loadData ()
    {
        let path = dataFilePath(for: myStrings.appendingPath)

        if let data = try? Data(contentsOf: path) {
            let unarhiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarhiver.decodeObject(forKey: myStrings.saveChecklistItems) as! [Checklist]
            unarhiver.finishDecoding()
        }
    }

    init() {
        loadData()
    }
    
}

