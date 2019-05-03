//
//  ServiceManager.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 29/12/17.
//

import Alamofire
import ObjectMapper
import CoreData



class ServiceManager {
    static func fetchPets( result: @escaping (_ result: [Pet], _ byCoreData: Bool) -> Void) {
        Alamofire.request(ServiceURLs.SEARCH_PET, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let pets = Mapper<Pet>().mapArray(JSONObject: value){
                    PetDAO.removeAllPets()
                    
                    do{
                        try Util.getManagedObjectContext().save()
                    }catch let error {
                        print(error.localizedDescription)
                    }
                    
                    result(pets, false)
                }
            case .failure(_):
                result(PetDAO.fetch(), true)
            }
        }
    }
    
    static func fetchEvents(result: @escaping (_ result: [Event] ) -> Void) {
        Alamofire.request(ServiceURLs.SEARCH_EVENTS, method: .get).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let events = Mapper<Event>().mapArray(JSONObject: value) {
                    result(events)
                }
            case .failure(_):
                result([])
            }
        }
    }
    
    
}




