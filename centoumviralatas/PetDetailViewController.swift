//
//  PetDetailViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 30/12/17.
//

import UIKit

class PetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var petTableView: UITableView!
    
    var pet: Pet!
    var info = [
        ["label" : "Nome", "hasImage": "name-cell", "info": ""], // nothing
        ["label" : "Anos Aproximado", "hasImage": "birthdate-cell", "info": ""],
        ["label" : "Sexo", "hasImage": "", "info": ""],
        ["label" : "Porte", "hasImage": "rule-cell", "info": ""]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.petTableView.tableFooterView = UIView()
        self.info[0]["info"] = self.pet.name
        self.info[1]["info"] = pet.yearsOld
        self.info[2]["info"] = self.pet.sex
        self.info[2]["hasImage"] = Util.defineGender(pet).name
        self.info[3]["info"] = self.pet.postage
        self.title = self.info[0]["info"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.info.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "PhotoPetCell", for: indexPath)
            let imageView = cell.viewWithTag(1) as! UIImageView
            imageView.image = UIImage(named: "no-photo")
            Util.loadImage(self.pet.photo!, completionHandler: { (image) in
                if let _ = image {
                    imageView.image = image
                }
            })
            
        case 1...10:
            cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
             cell.imageView?.image = nil
            let info = self.info[indexPath.row - 1]
            let title = cell.viewWithTag(1) as! UILabel
            let sub = cell.viewWithTag(2) as! UILabel
            title.text = info["label"]
            sub.text = info["info"]
            if info["hasImage"] != "" {
                cell.imageView?.image = UIImage(named: info["hasImage"]!)
            }
        default:
            break
        }
        
        return cell
        
        
    }

    @IBAction func clickOnAdote(_ sender: UIButton) {
        AppManager.shared.petSelected = self.pet
        AppManager.shared.show = true
        AppManager.shared.optionSelected = 3
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "goToContactForm"), object: nil)
        
    }
    
    @IBAction func clickOnApadrinhar(_ sender: UIButton) {
        AppManager.shared.petSelected = self.pet
        AppManager.shared.show = true
        AppManager.shared.optionSelected = 6
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "goToContactForm"), object: nil)
    }
    
}
