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
        handleFirstTime()
    }

    func registerDefaults()
    {
        let dictionary : [String: Any] = [myStrings.checklistIndex: -1, myStrings.firstTime: true]
        UserDefaults.standard.register(defaults: dictionary)
    }

    var indexOfSelectedChecklist: Int
    {
        get {
            return UserDefaults.standard.integer(forKey: myStrings.checklistIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: myStrings.checklistIndex)
            UserDefaults.standard.synchronize()
        }
    }

    func handleFirstTime()
    {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: myStrings.firstTime)

        if firstTime {
            let checklist = Checklist(name: myStrings.list)
            lists.append(checklist)

            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: myStrings.firstTime)
            userDefaults.synchronize()
        }
    }
    
}

