//
//  Event.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 12/04/19.
//

import Foundation
import ObjectMapper
import SwiftDate

class Event: Mappable {
    var eventId: String?
    var description: String?
    var local: String?
    var date: String?
    var initialTime: String?
    var endTime: String?
    var imagePath: String?
    var type: String?
    var title: String?
    
    var eventDate: DateInRegion {
        get {
            return DateInRegion(string: "\(self.date!) \(self.initialTime!)", format: .custom("yyyy-mm-dd hh:mm:ss"))!
        }
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        eventId <- map["idEvent"]
        description <- map["descricao"]
        local <- map["local"]
        date <- map["data"]
        initialTime <- map["horaInicio"]
        endTime <- map["horaFim"]
        imagePath <- map["imagem"]
        type <- map["tipo"]
        title <- map["titulo"]
    }
}
