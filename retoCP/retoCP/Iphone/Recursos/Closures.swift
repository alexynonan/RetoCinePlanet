//
//  Closures.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import Foundation

class Closures: NSObject {

    public typealias MessageString              = (_ message : String)                       -> Void
    public typealias MessagePayString           = (_ message : String,_ operation : String)    -> Void
    public typealias Success                    = ()                                         -> Void
    public typealias SuccessAction              = (()                                        -> ())?
    public typealias Premieres                  = (_ arrayBE : [PremiereBE])                 -> Void
    public typealias Candy                      = (_ arrayBE : [CandyStoreBE])               -> Void
}
