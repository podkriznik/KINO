//
//  Rezervacija.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 04/05/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import Foundation
class Rezervacija {
    var idSedezRezervacija:Int
    var statusSedeza:Bool
    var idRezervacija:Int
    var idSedez:Int
    var idTermin:Int
    
    init(idSedezRezervacija:Int, statusSedeza:Bool, idRezervacija:Int, idSedez:Int, idTermin:Int) {
        self.idSedezRezervacija = idSedezRezervacija
        self.statusSedeza = statusSedeza
        self.idRezervacija = idRezervacija
        self.idSedez = idSedez
        self.idTermin = idTermin
    }
}
