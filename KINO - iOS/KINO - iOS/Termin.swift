//
//  Termin.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 04/05/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import Foundation
class Termin {
    var idTermin:Int
    var cas:String
    var idFilm:Int
    
    init(idTermin:Int, cas:String, idFilm:Int) {
        self.idTermin = idTermin
        self.cas = cas
        self.idFilm = idFilm
    }
}
