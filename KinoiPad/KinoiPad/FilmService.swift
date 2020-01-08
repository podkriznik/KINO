//
//  FilmService.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 02/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import Foundation

class FilmService {
    var settings:Settings!
    
    init() {
        self.settings = Settings()
    }
    
    func getFilms(callback:@escaping (NSArray) -> ()) {
        request(url: settings.viewFilms, callback: callback)
    }
    
    func getTermini(callback:@escaping (NSArray) -> ()) {
        request(url: settings.viewTermin, callback: callback)
    }
    
    func getRezervacija(callback:@escaping (NSArray) -> ()) {
        request(url: settings.viewRezervacija, callback: callback)
    }
    
    func request(url:String, callback: @escaping (NSArray) -> ()){
        let nsURL = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: nsURL){
            (data, response, error) in
            let response = try? (JSONSerialization.jsonObject(with: data!, options: []) as! NSArray)
            callback(response!)
        }
        task.resume()
    }
}

