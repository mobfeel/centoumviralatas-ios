//
//  SocialTableViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 02/01/18.
//

import UIKit

class SocialTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnFace(_ sender: UIButton) {
        if let url = NSURL(string: "http://www.facebook.com/ong101viralatas/") { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnInsta(_ sender: UIButton) {
        if let url = NSURL(string: "https://www.instagram.com/101viralatas/") { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnTwitter(_ sender: UIButton) {
        if let url = NSURL(string: "https://www.twitter.com/101viralatas") { UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

   

}
