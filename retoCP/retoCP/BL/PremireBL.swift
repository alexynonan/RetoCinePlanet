//
//  PremireBL.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class PremireBL: NSObject {

    class func getPremieres(completion : @escaping Closures.Premieres,errorServices : @escaping Closures.MessageString){
        PremireWS.getPremieres(completion: completion, errorServices: errorServices)
    }
    
}
