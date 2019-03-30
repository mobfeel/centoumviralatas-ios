//
//  BeVoluntierViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 31/12/17.
//

import UIKit

class BeVoluntierViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableFooterView = UIView()
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(indexPath.row), for: indexPath)
        return cell
    }
    
    @IBAction func clickOnBeVoluntier(_ sender: UIButton) {
        AppManager.shared.show = true
        AppManager.shared.optionSelected = 9
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "goToContactForm"), object: nil)
    }
    
}
