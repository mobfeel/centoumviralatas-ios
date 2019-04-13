//
//  Transforms.swift
//  centoumviralatas
//
//  Created by Guilherme Leite Colares on 06/04/19.
//

import Foundation
import ObjectMapper


class Transforms {
    static let int = TransformOf<Int, AnyObject>(fromJSON: { (value: AnyObject?) -> Int? in
        // Check se o valor é válido, int ou string e retorna um int
        if value is Int{
            return value as? Int
        }else if (value == nil || value === NSNull()){
            return 0
        }
        return Int(value! as! String)
    }, toJSON: { (value: Int?) -> AnyObject? in
        return nil
    })
    
    static let int16 = TransformOf<Int16, AnyObject>(fromJSON: { (value: AnyObject?) -> Int16? in
        // Check se o valor é válido, int ou string e retorna um int
        if value is Int{
            return Int16(value as! Int)
        }else if (value == nil || value === NSNull()){
            return 0
        }
        return Int16(value! as! String)
    }, toJSON: { (value: Int16?) -> AnyObject? in
        return nil
    })

}


