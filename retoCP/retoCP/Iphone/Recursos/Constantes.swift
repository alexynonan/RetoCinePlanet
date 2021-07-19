//
//  Constantes.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import Foundation
import UIKit

public class ServicesURL: NSObject {
    
    public static let urlBase   = "http://ec2-18-219-76-53.us-east-2.compute.amazonaws.com:8080/cp/v1/"
                                  
    struct Premieres {
        static let premieres  = urlBase + "premieres"
    }
    
    struct Candy {
        static let candystore = urlBase + "candystore"
    }
    
    struct Complete {
        static let sendComplete = urlBase + "complete"
    }
    
    struct Pay {
        static let sendPay  = "https://sandbox.api.payulatam.com/payments-api/4.0/service.cgi"
    }
}

struct Segue {
    
    static let LoginViewController              = "LoginViewController"
    static let PremieresViewController          = "PremieresViewController"
    static let DulceriaViewController           = "DulceriaViewController"
    static let LoginPopViewController           = "LoginPopViewController"
    static let DulceriaDetailAddViewController  = "DulceriaDetailAddViewController"
    static let PayViewController                = "PayViewController"
}

struct CellIdentifier {
 
    static let PremieresCollectionViewCell  = "PremieresCollectionViewCell"
    static let DulceriaCollectionViewCell   = "DulceriaCollectionViewCell"
    static let HomeTableViewCell        = "HomeTableViewCell"
}


extension UIViewController{
    
    func classNameAsString() -> String{
        return String(describing: type(of: self))
    }
    
    @IBAction func btnExit(_ sender : Any?){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTapKeyboard(_ sender : Any?){
        self.view.endEditing(true)
    }
 
    @IBAction func btnDismiss(_ sender : Any?){
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIColor {
    
    class func colorFromHexString(_ hexString: String, withAlpha alpha: CGFloat) -> UIColor {
        
        let hexint = self.intFromHexString(hexString)
        
        let red = CGFloat((hexint & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hexint & 0xFF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private class func intFromHexString(_ hexString: String) -> UInt32{
        
        var hexInt : UInt32 = 0
        
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet.init(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        
        return hexInt
    }
}
