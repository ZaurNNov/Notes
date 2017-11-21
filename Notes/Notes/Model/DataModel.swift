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
        registerDefaults()
    }

    func registerDefaults()
    {
        let dictionary : [String: Any] = [myStrings.checklistIndex: -1]
        UserDefaults.standard.register(defaults: dictionary)
    }

    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: myStrings.checklistIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: myStrings.checklistIndex)
            UserDefaults.standard.synchronize()
        }
    }
    
}

