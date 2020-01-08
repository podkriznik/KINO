//
//  SecondViewController.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 13/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import UIKit

var filmi_second: [Film] = []
var id_filma_termin_post = -1

class SecondViewController: UIViewController {
    
    @IBOutlet weak var movie_label: UITextField!
    @IBOutlet weak var description_label: UITextField!
    @IBOutlet weak var genre_label: UITextField!
    @IBOutlet weak var duration_label: UITextField!
    @IBOutlet weak var rating_label: UITextField!
    @IBOutlet weak var director_label: UITextField!
    @IBOutlet weak var scenario_label: UITextField!
    @IBOutlet weak var date_label: UITextField!
    @IBOutlet weak var actors_label: UITextField!
    //@IBOutlet weak var termin_label: UITextField!
    
    @IBOutlet weak var label_error: UILabel!
    
    
    @IBOutlet weak var datapicker: UIDatePicker!
    
    
    
    
    @IBAction func add_film(_ sender: Any) {
        if movie_label.text!.count > 0 && description_label.text!.count > 0 && genre_label.text!.count > 0 && duration_label.text!.count > 0 && rating_label.text!.count > 0 && director_label.text!.count > 0 && scenario_label.text!.count > 0 && date_label.text!.count > 0{
            if Int(duration_label.text!) == nil {
                label_error.text = "You have to write number in duration and rating!"
                
                return
            }
            
            if Int(rating_label.text!) == nil {
                label_error.text = "You have to write number in duration and rating!"
                return
            }
        }
        else{
            label_error.text = "The fields are still empty!"
            return
        }
        
        
        
        let myURL = URL(string: "https://cinemauv.azurewebsites.net/api/Film")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "POST"
        let parameters: [String:Any?] = [
            "naslov": movie_label.text,
            "opis": description_label.text,
            "zanr": genre_label.text,
            "trajanje": Int(duration_label.text!),
            "ocena": Int(rating_label.text!),
            "direktor": director_label.text,
            "scenarij": scenario_label.text,
            "datumIzhoda": date_label.text,
            "zasedba": actors_label.text,
        ]
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            do {
                try JSONSerialization.jsonObject(with: data!, options:.allowFragments) //as? NSDictionary
                //print(try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary as Any)
                
            } catch let error {
                print("Error: \(error)")
            }
        }
        task.resume()
        let tmp = filmi_second.count
        viewDidLoad()
        
        if filmi_second.count <= tmp{
            sleep(1)
            viewDidLoad()
        }
        sleep(1)
        
        for r in filmi_second{
            print(r.naslov, self.movie_label.text!)
            if (r.naslov == self.movie_label.text)
            {
                id_filma_termin_post = r.id_film
            }
        }
        
        dodaj_termin(id_f: id_filma_termin_post)
        sleep(1)
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "1") as! ViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
        
        
        
    }
    
    func dodaj_termin(id_f:Int){
        let datum = datapicker.date
        let d_format = DateFormatter()
        d_format.dateFormat = "yyyy-MM-dd HH:mm:00"
        let a = d_format.string(from: datum)
        let components = a.split {$0 == " "}
        let datum_vnesi = components[0] + "T" + components[1]
        
        let myURL = URL(string: "https://cinemauv.azurewebsites.net/api/Termin")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "POST"
        let parameters: [String:Any?] = [
            "cas": datum_vnesi,
            "idFilm": id_f
        ]
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            do {
                try JSONSerialization.jsonObject(with: data!, options:.allowFragments) //as? NSDictionary
                //print(try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary as Any)
                
            } catch let error {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        
        datapicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        filmi_second = []
        var service:FilmService!
        
        service = FilmService()
        service.getFilms {
            (response) in
            loadFilms(films: response as! Array<NSDictionary>)
        }
        
        func loadFilms(films:Array<NSDictionary>) {
            for film in films {
                let id = film["idFilm"]! as! Int
                let naslov = film["naslov"]! as! String
                let opis = film["opis"]! as! String
                let zanr = film["zanr"]! as! String
                let trajanje = film["trajanje"]! as! Int
                let ocena = film["ocena"] as! Double
                let direktor = film["direktor"]! as! String
                let scenarij = film["scenarij"]! as! String
                let datumIzhoda = film["datumIzhoda"]! as! String
                let zasedba = film["zasedba"]! as! String
                
                let filmObj = Film(id_film: id, naslov: naslov, opis: opis, zanr: zanr, trajanje: trajanje, ocena: ocena, direktor: direktor, scenarij: scenarij, datumIzhoda: datumIzhoda, zasedba: zasedba)
                
                filmi_second.append(filmObj)
                DispatchQueue.main.async {
                    
                    //self.naslovLabel.text = filmCollection[1].naslov
                    //self.opisLabel.text = filmCollection[1].opis
                    //print(filmCollection[1].naslov)
                    
                }
            }
        }
        
        
    }
    
    
    
    
    
}
