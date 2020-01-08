//
//  Termin.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 04/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import Foundation

class Termin {
    var id_termin:Int
    var cas:Date
    var idfilm:Int
    
    init(id_termin:Int, cas:Date, idfilm:Int) {
        self.id_termin = id_termin
        self.cas = cas
        self.idfilm = idfilm
    }

    func toJSON() -> String {
        return ""
    }
}
