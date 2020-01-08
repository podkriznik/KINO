//
//  FilmService.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 02/05/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import Foundation

class Service {
    var settings:Settings!
    
    init() {
        self.settings = Settings()
    }
    
    func getFilmi(callback:@escaping (NSArray) -> ()) {
        request(url: settings.viewFilms, callback: callback)
    }
    
    func getTermini(callback:@escaping (NSArray) -> ()) {
        request(url: settings.viewTermin, callback: callback)
    }
    func getRezervacije(callback:@escaping (NSArray) -> ()) {
        request(url: settings.viewRezervacija, callback: callback)
    }
    
    func request(url:String, callback: @escaping (NSArray) -> ()){
        let nsURL = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: nsURL){
            (data, response, error) in
            let response = try? (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray)
            callback(response!)
        }
        task.resume()
    }
}
