//
//  PetDAO.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 12/04/19.
//

import CoreData

class PetDAO {
    
    static func removeAllPets(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Pet.entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        try! Util.getManagedObjectContext().execute(request)
    }
    
    
    static func fetch() -> [Pet] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Pet.entityName)
        return try! Util.getManagedObjectContext().fetch(fetchRequest) as! [Pet]
    }
    
}
