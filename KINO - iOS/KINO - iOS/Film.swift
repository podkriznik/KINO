//
//  Film.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 02/05/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import Foundation

class Film {
    var id_film:Int
    var naslov:String
    var opis:String
    var zanr:String
    var trajanje:Int
    var ocena:Double
    var direktor:String
    var scenarij:String
    var datumIzhoda:String
    var zasedba:String
    
    init(id_film:Int, naslov:String, opis:String, zanr:String, trajanje:Int, ocena:Double, direktor:String, scenarij:String, datumIzhoda:String, zasedba:String) {
        self.id_film = id_film
        self.naslov = naslov
        self.opis = opis
        self.zanr = zanr
        self.trajanje = trajanje
        self.ocena = ocena
        self.direktor = direktor
        self.scenarij = scenarij
        self.datumIzhoda = datumIzhoda
        self.zasedba = zasedba
    }
}
