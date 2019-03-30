//
//  ServiceManager.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 29/12/17.
//

import Alamofire

class ServiceManager {
    static let URL = "http://thiagocury.eti.br/101viralatas/sistema/"
    
    static func fetchPets( result: @escaping (_ result: [ [String: String] ]) -> Void) {
        let url = ServiceManager.URL + "buscar-pets.php"
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            if response.result.isSuccess {
                if let pets = response.result.value as? [ [String: String] ] {
                    result(pets)
                }else{
                    result([])
                }
            }else{
                result([])
            }
        }
    }
    
    static func fetchEvents(result: @escaping (_ result: [ [String: String] ] ) -> Void) {
        let url = ServiceManager.URL + "buscar-eventos.php"
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
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            if response.result.isSuccess {
                if let pets = response.result.value as? [ [String: String] ] {
                    result(pets)
                }else{
                    result([])
                }
            }else{
                result([])
            }
        }
    }
    
    static func loadImage(_ path: String, completionHandler:@escaping (_ image: UIImage? ) -> Void) {
        if path == "nenhum" || path == "Nenhum" || path == ""{
            completionHandler(nil)
        }else{
            var pathAux = path
            pathAux.removeFirst(3)
            let url = "http://thiagocury.eti.br/101viralatas/" + pathAux
            ImageLoader.sharedLoader.imageForUrl(url, completionHandler: { (image, url) in
                completionHandler(image)
            })
        }
    }
    
    
    
    
    
}




