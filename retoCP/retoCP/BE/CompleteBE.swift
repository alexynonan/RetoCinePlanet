//
//  CompleteBE.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class CompleteBE: NSObject {

    var name : String?
    var mail : String?
    var dni : String?
    var operation : String?
    
    var numeroTarjeta : String?
    var fechaExpiracion : String?
    var cvv             : String?
    var monto           : Double?
    
    class func send(obj : CompleteBE) -> [String : Any]{
        
        let data : [String : Any] = [ "language": "es",
                       "command": "SUBMIT_TRANSACTION",
                       "merchant": [
                          "apiLogin": "pRRXKOl8ikMmt9u",
                          "apiKey": "4Vj8eK4rloUd272L48hsrarnUA"
                       ],
                       "transaction": [
                          "order": [
                             "accountId": "512323",
                             "referenceCode": "TestPayU",
                             "description": "Test PAYU",
                             "language": "en",
                             "notifyUrl": "http://pruebaslap.xtrweb.com/lap/pruebconf.php",
                             "signature": "ba9ffa71559580175585e45ce70b6c37",
                             "shippingAddress": [
                                "country": "PE"
                             ],
                             "buyer": [
                                "fullName": "APPROVED",
                                "emailAddress": "test@payulatam.com",
                                "dniNumber": "731253256",
                                "shippingAddress": [
                                   "street1": "Calle 93 B 17 – 25",
                                   "city": "Panama",
                                   "state": "Panama",
                                   "country": "PE",
                                   "postalCode": "000000",
                                   "phone": "987654321"
                                ]
                             ],
                             "additionalValues": [
                                "TX_VALUE": [
                                    "value": Int(obj.monto ?? 0.0),
                                   "currency": "PEN"
                                ]
                             ]
                          ],
                          "creditCard": [
                            "number": obj.numeroTarjeta ?? "",
                            "securityCode": obj.cvv ?? "",
                            "expirationDate": obj.fechaExpiracion ?? "",
                            "name": obj.name ?? ""
                          ],
                          "type": "AUTHORIZATION_AND_CAPTURE",
                          "paymentMethod": "VISA",
                          "paymentCountry": "PE",
                          "payer": [
                            "fullName": obj.name ?? "",
                            "emailAddress": obj.mail ?? ""
                          ],
                          "ipAddress": "132.0.0.1",
                          "cookie": "cookie_52278879710130",
                          "userAgent": "Firefox",
                          "extraParameters": [
                             "INSTALLMENTS_NUMBER": 1,
                             "RESPONSE_URL": "http://www.misitioweb.com/respuesta.php"
                          ]
                       ],
                       "test": true]
        
        
        return data
    }
    
}
