//
//  Alert.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import Foundation

struct Alert {
    
    static let agreedButton             = "Entiendo"
    static let cancelButton             = "Cancelar"
    static let acceptButton             = "Aceptar"
    static let titleUpsError            = "UPS!"
    static let titleError               = "CinePlanet"
    
    
    struct Services {
        
        static let messageSession       = "No se pudo eliminar la session"
        static let problemServices      = "Problemas con el Servicio"
        static let messageOK            = "LICENCIA CONFORME REINICIE APP"
        static let messageError         = "LICENCIA NO VÁLIDA"
        static let messageLicencia      = "Ingrese la licencia"
    }
    
    struct Form {
        static let messageName          = "Ingrese el nombre"
        static let messageMail          = "Ingrese su correo"
        static let messageDocument      = "Ingrese su DNI"
        static let messageOperation     = "Ingrese la operacion"
        static let messageFecha         = "Ingrese una fecha valida"
        static let messageTarjeta       = "Ingrese una Tarjeta Valida"
        static let messageCvv           = "Ingrese un CVV valido"
    }
    
    struct Pay {
        static let messageSuccess       = "Compra Correcta"
        static let messagePay           = "Segur@ que quiere realizar el pago?"
        static let messageError         = "Pago no realizado, intentelo en uno minutos"
    }
}
