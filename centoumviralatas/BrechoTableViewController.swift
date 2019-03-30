//
//  BrechoTableViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 03/01/18.
//

import UIKit

class BrechoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            AppManager.shared.show = true
            AppManager.shared.optionSelected = 8
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "goToContactForm"), object: nil)
        default:
            break
        }
        
        
    }
  

}
