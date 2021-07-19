//
//  PayBL.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 19/07/21.
//

import UIKit

class PayBL: NSObject {

    class func sendPayment(obj : CompleteBE, completion : @escaping Closures.MessageString, errorServices : @escaping Closures.MessageString){
        
        if obj.numeroTarjeta?.trim().count ?? 0 < 15 {
            errorServices(Alert.Form.messageTarjeta)
            return
        }
        
        if obj.fechaExpiracion?.trim().count ?? 0 < 7 {
            errorServices(Alert.Form.messageFecha)
            return
        }

        if obj.cvv?.trim().count == 0 || obj.cvv?.trim().count ?? 0 < 2{
            errorServices(Alert.Form.messageCvv)
            return
        }
        
        if obj.mail?.mailIsValid() ?? false != true{
            errorServices(Alert.Form.messageMail)
            return
        }
        
        if obj.name?.trim().count == 0{
            errorServices(Alert.Form.messageName)
            return
        }

        if obj.dni?.trim().count ?? 0 < 7 {
            errorServices(Alert.Form.messageDocument)
            return
        }
        
        let objDic = CompleteBE.send(obj: obj)
        
        
        let header = CSMWebServiceHeaderRequest()
        
        header.contentType = .raw
        header.httpAdditionalHeaders = ["Content-Type" : "application/json" , "Accept" : "application/json"]
        
        PayWS.sendPayment(dic: objDic, header: header) { message, operation in
            
            obj.operation = operation
            
            CompleteBL.sendComplete(obj: obj) { message in
                
                completion("Compra correcta")
                
            } errorServices: { error in
                errorServices(error)
            }
        } errorServices: { error in
            errorServices(error)
        }
    }
    
}
