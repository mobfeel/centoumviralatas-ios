//
//  Pet.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 06/04/19.
//

import Foundation
import ObjectMapper
import CoreData


@objc(Pet)
class Pet: NSManagedObject, Mappable  {
    static let entityName = "Pet"
    
    @NSManaged var idPet: String?
    @NSManaged var qrCodePet: String?
    @NSManaged var name: String?
    @NSManaged var sex: String?
    @NSManaged var postage: String?
    @NSManaged var temper: String?
    @NSManaged var photo: String?
    @NSManaged var type: String?
    @NSManaged var isCut: Bool
    @NSManaged var isWalk: Bool
    @NSManaged var sector: String?
    @NSManaged var status: String?
    @NSManaged var history: String?
    @NSManaged var special: String?
    @NSManaged var obs: String?
    @NSManaged var canWalk: String?
    @NSManaged var createdAt: Date?
    @NSManaged var hasGodfather: Bool
    @NSManaged var nearYear: Int16
    
    public var yearsOld: String {
        get {
            if self.nearYear == 0 {
                return " N/A"
            }
            let date = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let total = year - Int(self.nearYear)
            if total > 1 {
                return " \(String(total)) ano(s)"
            }
            return " < de 1 ano"
        }
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: Util.getManagedObjectContext())
    }
    
    required init?(map: Map) {
        let context = Util.getManagedObjectContext()
        let entity = NSEntityDescription.entity(forEntityName: Pet.entityName, in: context)!
        super.init(entity: entity, insertInto: context)
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        idPet <- map["idPet"]
        qrCodePet <- map["QRCodePet"]
        name <- map["nomePet"]
        sex <- map["sexo"]
        postage <- map["porte"]
        temper <- map["temperamento"]
        photo <- map["fotoPet"]
        type <- map["tipo"]
        isCut <- map["estaCastrado"]
        isWalk <- map["estaPasseando"]
        sector <- map["setor"]
        status <- map["status"]
        history <- map["historia"]
        special <- map["necessidadesEspeciais"]
        obs <- map["obs"]
        canWalk <- map["podePassear"]
        createdAt <- (map["dataCadastro"], DateTransform ())
        hasGodfather <- map["temPadrinho"]
        nearYear <- (map["anoNascAprox"], Transforms.int16)
    }

}
