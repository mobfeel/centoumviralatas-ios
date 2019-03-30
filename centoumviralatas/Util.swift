//
//  Util.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 30/12/17.
//

import UIKit
import SwiftDate

class Util {
    static func defineGender(_ pet: [String: String]) -> (image: UIImage, name: String) {
        let gender = pet["sexo"]!.lowercased()
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
    
    static func getYearsOld(_ birthYear: String) -> String{
        if birthYear == "0" {
            return " N/A"
        }
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let total = year - Int(birthYear)!
        if total > 1 {
            return " \(String(total)) ano(s)"
        }
        
        return " < de 1 ano"
        
    }
    
    static func canWalk(_ pet: [String: String]) -> String {
        return pet["podePassear"] == "1" ? "Sim" : "Não"
    }
}

class AppManager {
    static let shared = AppManager()
    var options = ["Selecione","Agendamento de visita", "Coleta de doações", "Adoção", "Doação mensal", "Encomenda de Produto", "Padrinhos", "Patrocínio no site, App ou Facebook", "Produtos para brechó", "Voluntário", "Lar temporário", "Outro Assunto"]
    var optionSelected: Int?
    var petSelected: [String: String]?
    var eventSelected: [String: String]?
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
