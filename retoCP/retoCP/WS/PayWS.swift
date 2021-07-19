//
//  PayWS.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 19/07/21.
//

import UIKit

class PayWS: NSObject {

    class func sendPayment(dic : [String: Any],header : CSMWebServiceHeaderRequest, completion : @escaping Closures.MessagePayString, errorServices : @escaping Closures.MessageString){
        
        let url = ServicesURL.Pay.sendPay
        
        CSMWebServiceManager.shared.request.postRequest(urlString: url,header: header ,parameters: dic) { response in
            
            if let success = response.JSON?.dictionary["code"]?.stringValue, success == "SUCCESS"{
                
                let message = response.JSON?.dictionary["transactionResponse"]?.dictionary["responseMessage"]?.stringValue ?? ""
                let operation = response.JSON?.dictionary["transactionResponse"]?.dictionary["operationDate"]?.stringValue ?? ""
                
                completion(message,operation)
            }else{
                let error = response.JSON?.dictionary["error"]?.stringValue ?? Alert.Pay.messageError
                errorServices(error)
            }
        }
    }
    
}
