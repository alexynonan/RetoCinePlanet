//
//  CompleteWS.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class CompleteWS: NSObject {

    class func sendComplete(dic : [String : Any], completion : @escaping Closures.MessageString,errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Complete.sendComplete
        
        CSMWebServiceManager.shared.request.postRequest(urlString: urlBase, parameters: dic) { response in
            
            if let data = response.JSON?.dictionary["resul_code"]?.stringValue, data == "0"{
                completion(Alert.Pay.messageSuccess)
            }else{
                errorServices(Alert.Pay.messageError)
            }
        }
    }
    
}
