//
//  EventsTableViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 31/12/17.
//

import UIKit

let identifierShowEventDetail = "ShowEventDetail"

class EventsTableViewController: UITableViewController {

    @IBOutlet var loading: UIActivityIndicatorView!
    
    var eventsData: [Event] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ServiceManager.fetchEvents { (result) in
            self.loading.stopAnimating()
            self.eventsData = result
            self.tableView.reloadData()
        }
        self.tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.eventsData.count > 0 {
            return 1
        }
        
        if self.loading.isAnimating {
            return 0
        }
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text          = "Nenhum Evento Encontrado"
        noDataLabel.textColor     = UIColor.orange
        noDataLabel.textAlignment = .center
        tableView.backgroundView  = noDataLabel
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        let event = self.eventsData[indexPath.row]
        cell.lblTitle.text = event.title
        cell.lblLocation.text = event.local
        cell.lblType.text = event.title
        
        let eventDate = event.eventDate
        cell.lblDate.text = "\(eventDate.day) \(eventDate.shortMonthName) / \(eventDate.hour)h"
        cell.lblDateDesc.text = eventDate.string(dateStyle: .long, timeStyle: .short)
        
        Util.loadImage(event.imagePath!) { (image) in
            if let image = image {
                cell.coverPhoto.image = image
            }
        }
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = self.eventsData[indexPath.row]
        self.performSegue(withIdentifier: identifierShowEventDetail, sender: event)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case identifierShowEventDetail:
                let eventDetailController = segue.destination as! EventDetailViewController
                eventDetailController.event = sender as? Event
            default:
                break
            }
        }
    }

}
