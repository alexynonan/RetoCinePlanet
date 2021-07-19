//
//  UserSessionBL.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class UserSessionBL: NSObject {

    class func saveSession(objUser : UserBE) -> Bool{
        
        let session = UserDefaults.standard
        
        session.setValue(objUser.name, forKeyPath: "name")
        session.setValue(objUser.email, forKeyPath: "email")
        session.setValue(objUser.id, forKeyPath: "id")
        session.setValue(objUser.photo, forKeyPath: "photo")
        
        return session.synchronize()
    }
    
    class func deleteSession() -> Bool {
        
        let session = UserDefaults.standard
        
        session.removeObject(forKey: "name")
        session.removeObject(forKey: "email")
        session.removeObject(forKey: "id")
        session.removeObject(forKey: "photo")
        
        return session.synchronize()
    }
    
    class func getSession() -> UserBE? {
        
        let objBE = UserBE()
        
        let session = UserDefaults.standard
        
        guard let name = session.value(forKey: "name") else { return nil }
        guard let email = session.value(forKey: "email") else { return nil }
        guard let id = session.value(forKey: "id") else { return nil }
        guard let photo = session.value(forKey: "photo") else { return nil }
        
        objBE.name = name as? String
        objBE.email = email as? String
        objBE.id = id as? String
        objBE.photo = photo as? String
        
        return objBE
    }
}
