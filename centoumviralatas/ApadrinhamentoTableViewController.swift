//
//  ApadrinhamentoTableViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 02/01/18.
//

import UIKit

class ApadrinhamentoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1: //contato
            AppManager.shared.show = true
            AppManager.shared.optionSelected = 6
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "goToContactForm"), object: nil)
            
        case 2:
            self.tabBarController?.selectedIndex = 0
        default:
            break
        }
    }
    


}
