//
//  EventDetailTableViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 12/01/18.
//

import UIKit
import SwiftDate

class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var eventTableView: UITableView!
    
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventTableView.delegate = self
        self.eventTableView.dataSource = self
        self.eventTableView.tableFooterView = UIView()
        self.title = self.event.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = self.event.eventDate
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoverPhotoCell", for: indexPath)
            let imageView = cell.viewWithTag(1) as! UIImageView
            Util.loadImage(self.event.imagePath!) { (image) in
                if let image = image {
                    imageView.image = image
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoDateCell", for: indexPath)
            let lblDay = cell.viewWithTag(1) as! UILabel
            let lblMonth = cell.viewWithTag(2) as! UILabel
            let lblTitle = cell.viewWithTag(3) as! UILabel
            let lblDesc = cell.viewWithTag(4) as! UILabel
            
            
            lblDay.text = "\(date.day)"
            lblMonth.text = "\(date.shortMonthName)".uppercased()
            lblTitle.text = self.event.title
            lblDesc.text = self.event.description
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            cell.imageView?.image = UIImage(named: "time-cell")
            let lblTitle = cell.viewWithTag(1) as! UILabel
            lblTitle.text = date.string(dateStyle: .long, timeStyle: .short)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            cell.imageView?.image = UIImage(named: "location-cell")
            (cell.viewWithTag(1) as! UILabel).text = self.event.local
            return cell
        default:
            break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = self.event.type
        return cell
     
        
    }
    
    @IBAction func clickOnParticipate(_ sender: UIButton) {
        AppManager.shared.show = true
        AppManager.shared.optionSelected = 9
        AppManager.shared.eventSelected = self.event
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "goToContactForm"), object: nil)
    }
    
}
