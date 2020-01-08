//
//  SedezRezervacija.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 05/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import Foundation

class SedezRezervacija{
    var id_sedezRezervacija:Int
    var statusSedeza:Bool
    var idSedeza:Int
    var idRezervacija:Int
    var idTermin:Int
    
    init(id_sedezRezervacija:Int,statusSedeza:Bool,idSedeza:Int,idRezervacija:Int,idTermin:Int) {
        self.id_sedezRezervacija = id_sedezRezervacija
        self.statusSedeza = statusSedeza
        self.idSedeza = idSedeza
        self.idRezervacija = idRezervacija
        self.idTermin = idTermin
    }
    
    func toJSON() -> String {
        return ""
    }
    
}
