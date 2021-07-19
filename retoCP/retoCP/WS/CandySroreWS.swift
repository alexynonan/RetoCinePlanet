//
//  CandySroreWS.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class CandySroreWS: NSObject {

    class func getCandy(completion : @escaping Closures.Candy,errorServices : @escaping Closures.MessageString){
        
        let urlBase = ServicesURL.Candy.candystore
        
        CSMWebServiceManager.shared.request.getRequest(urlString: urlBase, parameters: nil) { response in
            
            if let data = response.JSON?.dictionary["items"]?.array{
                
                var arrayBE = [CandyStoreBE]()
                
                var index = 0
                
                for item in data{
                    
                    index += 1
                    
                    let obj = CandyStoreBE.parse(item)
                    
                    obj.id = index
                    
                    arrayBE.append(obj)
                }
                
                completion(arrayBE)
            }else{
                errorServices(Alert.Services.problemServices)
            }
        }
    }
    
    
}
