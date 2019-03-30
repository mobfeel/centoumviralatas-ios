//
//  MensalTableViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 02/01/18.
//

import UIKit
import SafariServices

class MensalTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
      
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row != 0 && indexPath.row != 1 {
            let links = ["","",
                         "https://pagseguro.uol.com.br/v2/pre-approvals/request.html?code=41066BC662625E96648CAF85043464A5",
                         "https://pagseguro.uol.com.br/v2/pre-approvals/request.html?code=7ED0FFA99B9B050774DC2F946A3F1025",
                         "https://pagseguro.uol.com.br/v2/pre-approvals/request.html?code=C32E4D405F5F01133451CF970F11CA3C",
                         "https://pagseguro.uol.com.br/v2/pre-approvals/request.html?code=4ABBF233C4C47FE224839FA983995C3A",
                         "https://pagseguro.uol.com.br/v2/pre-approvals/request.html?code=09F2FA68C7C77AE8846F8FB52FF2C521",
                         "https://pagseguro.uol.com.br/v2/pre-approvals/request.html?code=48DF4FBED8D8524AA4865FABC5CB5134"
            ]
            
            let url = URL(string: links[indexPath.row])!
            let svc = SFSafariViewController(url: url)
            svc.preferredBarTintColor = UIColor.orange
            svc.preferredControlTintColor = .white
            self.present(svc, animated: true, completion: nil)
        }
        
    }

 

}
