//
//  PremiereBE.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class PremiereBE: NSObject {

    var image : String?
    var descripcion : String?
    
    class func parse(_ json : CSMJSON) -> PremiereBE {
        
        let objBE = PremiereBE()
        
        objBE.image = json.dictionary["image"]?.stringValue ?? ""
        objBE.descripcion = json.dictionary["description"]?.stringValue ?? ""
        
        return objBE
    }
}
