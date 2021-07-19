//
//  CompleteBL.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class CompleteBL: NSObject {

    class func sendComplete(obj : CompleteBE, completion : @escaping Closures.MessageString,errorServices : @escaping Closures.MessageString){
        
        let dic : [String : Any] = ["name" : obj.name ?? "","mail" : obj.mail ?? "","dni" : obj.dni ?? "","operation_date" : obj.operation ?? ""]
        
        CompleteWS.sendComplete(dic: dic, completion: completion, errorServices: errorServices)
    }
    
}
