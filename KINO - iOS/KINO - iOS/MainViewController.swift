//
//  ViewController.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 27/04/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//
import UIKit

var filmCollection: [Film] = []
var terminCollection: [Termin] = []
var rezervacijaCollection: [Rezervacija] = []

class MainViewController: UIViewController {
    
    var service:Service!
    //@IBOutlet weak var naslovLabel: UILabel!
    //@IBOutlet weak var opisLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        filmCollection.removeAll()
        terminCollection.removeAll()
        rezervacijaCollection.removeAll()
        
        service = Service()
        service.getFilmi {
            (response) in
            loadFilmi(films: response as! Array<NSDictionary>)
        }
        
        service.getTermini {
            (response) in
            loadTermini(termins: response as! Array<NSDictionary>)
        }
        
        service.getRezervacije {
            (response) in
            loadRezervacije(rezervacije: response as! Array<NSDictionary>)
        }
        
        
        func loadFilmi(films:Array<NSDictionary>) {
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
                
                filmCollection.append(filmObj)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func loadTermini(termins:Array<NSDictionary>){
            for termin in termins {
                let id = termin["idTermin"]! as! Int
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let tmp = dateFormatter.date(from: termin["cas"]! as! String)!
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = DateFormatter.Style.long
                dateformatter.timeStyle = DateFormatter.Style.short
                
                let cas = dateformatter.string(from: tmp)
                let idFilm = termin["idFilm"]! as! Int
                let terminObj = Termin(idTermin: id, cas: cas, idFilm: idFilm)
                
                terminCollection.append(terminObj)
            }
            DispatchQueue.main.async {
                // Nekaj
            }
        }
        
        func loadRezervacije(rezervacije:Array<NSDictionary>){
            for rezervacija in rezervacije {
                let id = rezervacija["idSedezRezervacija"]! as! Int
                let statusSedeza = rezervacija["statusSedeza"]! as! Bool
                let idSedez = rezervacija["idSedez"]! as! Int
                let idRezervacija = rezervacija["idRezervacija"]! as! Int
                let idTermin = rezervacija["idTermin"]! as! Int
                
                let rezervacijaObj = Rezervacija(idSedezRezervacija: id, statusSedeza: statusSedeza, idRezervacija: idRezervacija, idSedez: idSedez, idTermin: idTermin)
                rezervacijaCollection.append(rezervacijaObj)
            }
            DispatchQueue.main.async {
                //Nekaj
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellMain
        cell?.img.image = UIImage(named: filmCollection[indexPath.row].naslov)
        cell?.titleLabel.text = (filmCollection[indexPath.row].naslov).uppercased()
        cell?.descriptionLabel.text = filmCollection[indexPath.row].opis
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Description") as? DescriptionViewController
        vc?.index = indexPath.row
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
