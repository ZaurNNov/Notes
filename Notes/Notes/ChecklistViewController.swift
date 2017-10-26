//
//  ChecklistViewController.swift
//  Notes
//
//  Created by Zaur Giyasov on 26/10/2017.
//  Copyright © 2017 ZaurGiyasov. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    //my id for cell and segue
    private struct customId {
        static let ChecklistItem = "ChecklistItem"
        static let cellLabelTag = 100
        
    }
    
    

    
    

    //MARK: TableView Data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customId.ChecklistItem, for: indexPath)
        
        //test
        let label = cell.viewWithTag(customId.cellLabelTag) as! UILabel
        label.text = "Learn iOS development"
        
        return cell
    }

    
}

