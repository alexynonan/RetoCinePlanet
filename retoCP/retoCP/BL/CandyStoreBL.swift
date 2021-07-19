//
//  CandyStoreBL.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class CandyStoreBL: NSObject {

    class func getCandy(completion : @escaping Closures.Candy,errorServices : @escaping Closures.MessageString){
        
        CandySroreWS.getCandy(completion: completion, errorServices: errorServices)        
    }
    
}
