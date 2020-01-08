//
//  ThirdViewController.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 13/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import UIKit

var film_delete: [Film] = []
var indexi_filmov: [Int] = []

var index_filma = -1

class ThirdViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var picker3: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return film_delete.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return film_delete[row].naslov
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: film_delete[row].naslov, attributes: [.foregroundColor: UIColor.lightGray])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        index_filma = indexi_filmov[row]
    }
    
    @IBAction func delete_film(_ sender: Any) {
        viewDidLoad()
        print(index_filma)
        let url = URL(string: "https://cinemauv.azurewebsites.net/api/Film/\(index_filma)")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { print(error!); return }
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data!) as? String {
                    print(jsonObj)
                    DispatchQueue.main.async {
                        //self.tableDetails.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        sleep(1)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        
        picker3.setValue(UIColor.white, forKeyPath: "textColor")
        
        film_delete = []
        indexi_filmov = []
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
                
                film_delete.append(filmObj)
                indexi_filmov.append(id)
                DispatchQueue.main.async {
                    self.picker3.reloadAllComponents()
                    self.picker3.selectRow(0, inComponent: 0, animated: true)
                    //self.naslovLabel.text = filmCollection[1].naslov
                    //self.opisLabel.text = filmCollection[1].opis
                    //print(filmCollection[1].naslov)
                    
                }
            }
        }
        
        
    }
    
    
}
