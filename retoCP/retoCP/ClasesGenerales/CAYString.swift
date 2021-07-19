//
//  CAYString.swift
//  Mapsalud
//
//  Created by Alexander Ynoñan H. on 10/07/19.
//

import UIKit

public extension String{
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func mailIsValid() -> Bool {

        let emailRegex = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    
    func replacing(range: CountableClosedRange<Int>, with replacementString: String) -> String {
        
        let start = index(replacementString.startIndex, offsetBy: range.lowerBound)
        let end   = index(start, offsetBy: range.count)
        return self.replacingCharacters(in: start ..< end, with: replacementString)
    }
    
}
