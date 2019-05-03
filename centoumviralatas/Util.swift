//
//  Util.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 30/12/17.
//

import UIKit
import SwiftDate
import CoreData

class Util {
    static func defineGender(_ pet: Pet) -> (image: UIImage, name: String) {
        let gender = pet.sex!.lowercased()
        let image = (gender == "macho" ? UIImage(named: "male-gender") : UIImage(named: "female-gender"))!
        let name = (gender == "macho" ? "male-cell" : "female-cell")
        return (image, name)
    }
    
    static func convertBoolParam(_ param: String) -> String{
        return param == "1" ? "Sim" : "Não"
    }
    
    static func getEventDate(_ event: [String: String]) -> DateInRegion {
        return DateInRegion(string: "\(event["data"]!) \(event["horaInicio"]!)", format: .custom("yyyy-mm-dd hh:mm:ss"))!
    }
    
    static func canWalk(_ pet: [String: String]) -> String {
        return pet["podePassear"] == "1" ? "Sim" : "Não"
    }
    
    static func getManagedObjectContext() -> NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    static func loadImage(_ path: String, completionHandler:@escaping (_ image: UIImage? ) -> Void) {
        if path == "nenhum" || path == "Nenhum" || path == "" {
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

class AppManager {
    static let shared = AppManager()
    var options = ["Selecione","Agendamento de visita", "Coleta de doações", "Adoção", "Doação mensal", "Encomenda de Produto", "Padrinhos", "Patrocínio no site, App ou Facebook", "Produtos para brechó", "Voluntário", "Lar temporário", "Outro Assunto"]
    var optionSelected: Int?
    var petSelected: Pet?
    var eventSelected: Event?
    var msg = ""
    var show = false
    
}

extension Date {
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
}
