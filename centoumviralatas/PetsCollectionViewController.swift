//
//  PetsCollectionViewController.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 29/12/17.
//

import UIKit
import CoreData
import CRNotifications

private let petCellIdentifier = "PetCell"
private let segueIdentfierShowPetDetail = "ShowPetDetail"

class PetsCollectionViewController: UICollectionViewController {
    
    @IBOutlet var loading: UIActivityIndicatorView!
    
    var petsData: [Pet] = []
    var petsOrigin: [Pet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PetsCollectionViewController.goToContactForm(notification:)),
                                               name: Notification.Name(rawValue: "goToContactForm"),
                                               object: nil)
        self.fetchPets()
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(PetsCollectionViewController.refreshControlAction(action:)), for: UIControl.Event.valueChanged)
        self.collectionView?.addSubview(refreshControl)
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.petsData.count > 0 {
            collectionView.backgroundView = nil
            return 1
        }
        
        if self.loading.isAnimating {
            return 0
        }
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        noDataLabel.text          = "Nenhum Pet Encontrado"
        noDataLabel.textColor     = UIColor.orange
        noDataLabel.textAlignment = .center
        collectionView.backgroundView  = noDataLabel
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.petsData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pet = self.petsData[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: petCellIdentifier, for: indexPath)
        
        cell.layer.shadowColor = UIColor.black.cgColor
      //  cell.layer.shadowOffset = CGSize(width: 100, height: 20)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 5
        cell.layer.cornerRadius = 5.0
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        
        let petImage = cell.viewWithTag(1) as! UIImageView
        let lblName = cell.viewWithTag(2) as! UILabel
        let lblSize = cell.viewWithTag(3) as! UILabel
        let genderImageView = cell.viewWithTag(4) as! UIImageView
        let lblYears = cell.viewWithTag(5) as! UILabel
        
        petImage.image = UIImage(named: "no-photo")
        
        lblYears.text = pet.yearsOld
        lblName.text = pet.name
        lblSize.text = pet.postage
        
        Util.loadImage(pet.photo!) { (image) in
            if let image = image {
                petImage.image = image
            }
        }
        genderImageView.image = Util.defineGender(pet).image
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pet = self.petsData[indexPath.row]
        self.performSegue(withIdentifier: segueIdentfierShowPetDetail, sender:pet)
    }
    
    func fetchPets(){
        ServiceManager.fetchPets { (pets, byCoreData) in
            self.petsData = pets
            self.petsOrigin = pets
            self.collectionView?.reloadData()
            self.loading.stopAnimating()
            
            if byCoreData {
                CRNotifications.showNotification(type: .success, title: "CoreData", message: "Pets buscados pelo CoreData", dismissDelay: 3)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowPetDetail":
                let pdvc = segue.destination as! PetDetailViewController
                pdvc.pet = sender as? Pet
            default:
                break
                
            }
        }
    }

    @IBAction func clickOnFilter(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func refreshControlAction(action: UIRefreshControl){
        action.endRefreshing()
        self.fetchPets()
    }
   
    @objc func goToContactForm(notification: NSNotification){
        self.tabBarController?.selectedIndex = 3
    }
    
    
    @IBAction func backFromFilterByPets(segue: UIStoryboardSegue) {
        if self.petsOrigin.count > 0 {
            self.petsData = self.petsOrigin.filter({ (pet) -> Bool in
                var show = true
                if Filter.shared.porte != Porte.Todos {
                    if pet.postage != Filter.shared.porte.rawValue {
                        show = false
                    }
                }
                
                if Filter.shared.especie != Especie.Todos {
                    if pet.type != Filter.shared.especie.rawValue.lowercased() {
                        show = false
                    }
                }
                
                if Filter.shared.sexo != Sexo.Todos {
                    if pet.sex != Filter.shared.sexo.rawValue.lowercased() {
                        show = false
                    }
                }
                
                return show
            })
            self.collectionView?.reloadData()
        }
        
    }
    

}
