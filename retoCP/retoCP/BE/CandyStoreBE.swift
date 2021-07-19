//
//  CandyStoreBE.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class CandyStoreBE: NSObject {

    var name : String?
    var descripcion : String?
    var price : String?
    var id  = 0
    var sum_produc = 0
    
    class func parse(_ json : CSMJSON) -> CandyStoreBE {
        
        let objBE = CandyStoreBE()
        
        objBE.name = json.dictionary["name"]?.stringValue ?? ""
        objBE.descripcion = json.dictionary["description"]?.stringValue ?? ""
        objBE.price = json.dictionary["price"]?.stringValue ?? ""
        
        return objBE
    }
    
}
