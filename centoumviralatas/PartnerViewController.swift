//
//  PartnerViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 02/01/18.
//

import UIKit
import SafariServices

class PartnerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickOnPartner(_ sender: UIButton) {
        let links = ["",
                     "http://www.thiagocury.eti.br",
                     "http://www.taurussuplementos.com.br/",
                     "http://www.dasppet.com.br/rs/index.html",
                     "http://sosracoes.com.br/",
                     "http://www.clinicavetmax.com.br/",
                     "http://agrosul.com/"
        ]
        
        let url = URL(string: links[sender.tag])!
        let svc = SFSafariViewController(url: url)
        svc.preferredBarTintColor = UIColor.orange
        svc.preferredControlTintColor = .white
        self.present(svc, animated: true, completion: nil)
    }
}
