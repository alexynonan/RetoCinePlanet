//
//  PremireWS.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class PremireWS: NSObject {

    class func getPremieres(completion : @escaping Closures.Premieres,errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Premieres.premieres
        
        CSMWebServiceManager.shared.request.getRequest(urlString: urlBase, parameters: nil) { response in
            
            if let data = response.JSON?.dictionary["premieres"]?.array{
                
                var arrayBE = [PremiereBE]()
                
                for item in data{
                    arrayBE.append(PremiereBE.parse(item))
                }
                
                completion(arrayBE)
            }else{
                errorServices(Alert.Services.problemServices)
            }
        }
    }
    
}
