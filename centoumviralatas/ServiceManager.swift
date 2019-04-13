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
    static func fetchPets( result: @escaping (_ result: [Pet]) -> Void) {
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
                    
                    result(pets)
                }
            case .failure(_):
                result(PetDAO.fetch())
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
        
        
//        [{"idEvento":"2","titulo":"Mutirão de Banho","descricao":"Venha auxiliar no banho dos nossos peludinhos","local":"na ONG","data":"2018-01-31","horaInicio":"08:00:00","horaFim":"18:00:00","imagem":"../fotos-eventos/2.jpg","tipo":"Banho"}]
//        let events = [
//            [
//                "idEvento": "2",
//                "titulo": "Mutirão de Banho",
//                "descricao": "Venha auxiliar no banho dos nossos peludinhos",
//                "local": "na ONG",
//                "data": "2018-01-31",
//                "horaInicio": "08:00:00",
//                "horaFim": "18:00:00",
//                "imagem": "../fotos-eventos/2.jpg",
//                "tipo": "Banho"
//            ]
//
//        ]
//
//        result(events)
//
        
//        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
//            if response.result.isSuccess {
//                if let pets = response.result.value as? [ [String: String] ] {
//                    result(pets)
//                }else{
//                    result([])
//                }
//            }else{
//                result([])
//            }
//        }
    }
    
    static func loadImage(_ path: String, completionHandler:@escaping (_ image: UIImage? ) -> Void) {
        if path == "nenhum" || path == "Nenhum" || path == ""{
            completionHandler(nil)
        }else{
            var pathAux = path
            pathAux.removeFirst(3)
            let url = ServiceURLs.PHOTOS + pathAux
            ImageLoader.sharedLoader.imageForUrl(url, completionHandler: { (image, url) in
                completionHandler(image)
            })
        }
    }
    
    
    
    
    
}




