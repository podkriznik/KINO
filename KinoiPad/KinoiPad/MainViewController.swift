//
//  ViewController.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 02/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import UIKit

var filmCollection: [Film] = []
var data: [String] = []
var subtitles: [String] = []
var slike: [String] = []
var selected_film = -1
var izbrTermin = ""
var izbrTerminIndex = -1

var terminCollection: [Termin] = []
var rezervacijaCollection: [Rezervacija] = []
var izbraniTermini:[String] = [String]()
var indexTermini:[Int] = []
var sedeziVstavi:Set<Int> = []
var cena = 0
var st_seats = 0
var id_filma = -1

var sedezi_check: [Int] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet weak var label_termin: UILabel!
    //@IBOutlet weak var label_ura: UILabel!
    @IBOutlet weak var label_movie: UILabel!
    @IBOutlet weak var label_seats: UILabel!
    @IBOutlet weak var btn_pay: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var textfield_check: UITextField!
    @IBOutlet weak var label_check: UILabel!
    
    
    @IBAction func refresh(_ sender: Any) {
        
        picker.isHidden = true
        
        getData()
        enableAll()
        usleep(500000)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        selected_film = indexPath.row
        set_btn_false_free()
        st_seats = 0
        label_seats.text = String(st_seats)
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        if (v == 0.0)
        {
            btn_pay.setTitle("Pay", for: .normal)
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        
        
        //let indexTermin:Int = -1
        for t in terminCollection{
            if t.idfilm == selected_film
            {
                let d_format = DateFormatter()
                d_format.dateFormat = "dd.MM.yyyy"
                //label_termin.text = d_format.string(from: t.cas)
                
                let u_format = DateFormatter()
                u_format.dateFormat = "HH:mm"
                //label_ura.text = u_format.string(from: t.cas)
                //indexTermin = t.id_termin
                //print(indexTermin)
            }
        }
        id_filma = -1
        //for f in filmCollection{
        //if f.id_film == selected_film{
        print(filmCollection)
        label_movie.text = filmCollection[selected_film].naslov
        id_filma = filmCollection[selected_film].id_film
        //}
        //}
        enableAll()
        //picker.selectRow(0, inComponent: 0, animated: true)
        reserved(id_filma: id_filma)
        picker.isHidden = false
        self.picker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(picker, didSelectRow: 0, inComponent: 0)
        
        
        
        
        
    }
    
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var btn16: UIButton!
    @IBOutlet weak var btn17: UIButton!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn23: UIButton!
    @IBOutlet weak var btn24: UIButton!
    @IBOutlet weak var btn25: UIButton!
    @IBOutlet weak var btn26: UIButton!
    @IBOutlet weak var btn27: UIButton!
    @IBOutlet weak var btn31: UIButton!
    @IBOutlet weak var btn32: UIButton!
    @IBOutlet weak var btn33: UIButton!
    @IBOutlet weak var btn34: UIButton!
    @IBOutlet weak var btn35: UIButton!
    @IBOutlet weak var btn36: UIButton!
    @IBOutlet weak var btn37: UIButton!
    @IBOutlet weak var btn41: UIButton!
    @IBOutlet weak var btn42: UIButton!
    @IBOutlet weak var btn43: UIButton!
    @IBOutlet weak var btn44: UIButton!
    @IBOutlet weak var btn45: UIButton!
    @IBOutlet weak var btn46: UIButton!
    @IBOutlet weak var btn47: UIButton!
    @IBOutlet weak var btn51: UIButton!
    @IBOutlet weak var btn52: UIButton!
    @IBOutlet weak var btn53: UIButton!
    @IBOutlet weak var btn54: UIButton!
    @IBOutlet weak var btn55: UIButton!
    @IBOutlet weak var btn56: UIButton!
    @IBOutlet weak var btn57: UIButton!
    @IBOutlet weak var btn61: UIButton!
    @IBOutlet weak var btn62: UIButton!
    @IBOutlet weak var btn63: UIButton!
    @IBOutlet weak var btn64: UIButton!
    @IBOutlet weak var btn65: UIButton!
    @IBOutlet weak var btn66: UIButton!
    @IBOutlet weak var btn67: UIButton!
    
    
    
    
    
    
    @IBAction func pay_gumb(_ sender: Any) {
        let number = Int.random(in: 0 ... 10000)
        for sedez in sedeziVstavi {
            let myURL = URL(string: "https://cinemauv.azurewebsites.net/api/Rezervacija")
            var request = URLRequest(url: myURL!)
            request.httpMethod = "POST"
            let parameters: [String:Any?] = [
                "statusSedeza": true,
                "idSedez": sedez,
                "idRezervacija": number,
                "idTermin": izbrTerminIndex,
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
        
        terminCollection = []
        filmCollection = []
        rezervacijaCollection = []
        sedeziVstavi = []
        data = []
        subtitles = []
        slike = []
        indexTermini = []
        st_seats = 0
        label_seats.text = "Seats"
        cena = 0
        btn_pay.setTitle("PAY", for: .normal)
        label_movie.text = "Movie"
        label_check.text = ""
        
        
        //enableAll()
        
        
        
        set_btn_false_free()
        
        usleep(500000)
        //reserved(id_filma: id_filma)
        refresh(sender)
        
        
        
    }
    func set_btn_false_free(){
        btn11.setImage(UIImage(named: "free.png")!, for: .normal)
        btn11.isSelected = false
        btn12.setImage(UIImage(named: "free.png")!, for: .normal)
        btn12.isSelected = false
        btn13.setImage(UIImage(named: "free.png")!, for: .normal)
        btn13.isSelected = false
        btn14.setImage(UIImage(named: "free.png")!, for: .normal)
        btn14.isSelected = false
        btn15.setImage(UIImage(named: "free.png")!, for: .normal)
        btn15.isSelected = false
        btn16.setImage(UIImage(named: "free.png")!, for: .normal)
        btn16.isSelected = false
        btn17.setImage(UIImage(named: "free.png")!, for: .normal)
        btn17.isSelected = false
        
        btn21.setImage(UIImage(named: "free.png")!, for: .normal)
        btn21.isSelected = false
        btn22.setImage(UIImage(named: "free.png")!, for: .normal)
        btn22.isSelected = false
        btn23.setImage(UIImage(named: "free.png")!, for: .normal)
        btn23.isSelected = false
        btn24.setImage(UIImage(named: "free.png")!, for: .normal)
        btn24.isSelected = false
        btn25.setImage(UIImage(named: "free.png")!, for: .normal)
        btn25.isSelected = false
        btn26.setImage(UIImage(named: "free.png")!, for: .normal)
        btn26.isSelected = false
        btn27.setImage(UIImage(named: "free.png")!, for: .normal)
        btn27.isSelected = false
        
        btn31.setImage(UIImage(named: "free.png")!, for: .normal)
        btn31.isSelected = false
        btn32.setImage(UIImage(named: "free.png")!, for: .normal)
        btn32.isSelected = false
        btn33.setImage(UIImage(named: "free.png")!, for: .normal)
        btn33.isSelected = false
        btn34.setImage(UIImage(named: "free.png")!, for: .normal)
        btn34.isSelected = false
        btn35.setImage(UIImage(named: "free.png")!, for: .normal)
        btn35.isSelected = false
        btn36.setImage(UIImage(named: "free.png")!, for: .normal)
        btn36.isSelected = false
        btn37.setImage(UIImage(named: "free.png")!, for: .normal)
        btn37.isSelected = false
        
        btn41.setImage(UIImage(named: "free.png")!, for: .normal)
        btn41.isSelected = false
        btn42.setImage(UIImage(named: "free.png")!, for: .normal)
        btn42.isSelected = false
        btn43.setImage(UIImage(named: "free.png")!, for: .normal)
        btn43.isSelected = false
        btn44.setImage(UIImage(named: "free.png")!, for: .normal)
        btn44.isSelected = false
        btn45.setImage(UIImage(named: "free.png")!, for: .normal)
        btn45.isSelected = false
        btn46.setImage(UIImage(named: "free.png")!, for: .normal)
        btn46.isSelected = false
        btn47.setImage(UIImage(named: "free.png")!, for: .normal)
        btn47.isSelected = false
        
        btn51.setImage(UIImage(named: "free.png")!, for: .normal)
        btn51.isSelected = false
        btn52.setImage(UIImage(named: "free.png")!, for: .normal)
        btn52.isSelected = false
        btn53.setImage(UIImage(named: "free.png")!, for: .normal)
        btn53.isSelected = false
        btn54.setImage(UIImage(named: "free.png")!, for: .normal)
        btn54.isSelected = false
        btn55.setImage(UIImage(named: "free.png")!, for: .normal)
        btn55.isSelected = false
        btn56.setImage(UIImage(named: "free.png")!, for: .normal)
        btn56.isSelected = false
        btn57.setImage(UIImage(named: "free.png")!, for: .normal)
        btn57.isSelected = false
        
        btn61.setImage(UIImage(named: "free.png")!, for: .normal)
        btn61.isSelected = false
        btn62.setImage(UIImage(named: "free.png")!, for: .normal)
        btn62.isSelected = false
        btn63.setImage(UIImage(named: "free.png")!, for: .normal)
        btn63.isSelected = false
        btn64.setImage(UIImage(named: "free.png")!, for: .normal)
        btn64.isSelected = false
        btn65.setImage(UIImage(named: "free.png")!, for: .normal)
        btn65.isSelected = false
        btn66.setImage(UIImage(named: "free.png")!, for: .normal)
        btn66.isSelected = false
        btn67.setImage(UIImage(named: "free.png")!, for: .normal)
        btn67.isSelected = false
    }
    
    @IBAction func btn11(_ sender: Any) {
        if selected_film != -1
        {
            btn11.isSelected = !btn11.isSelected
            if btn11.isSelected
            {
                btn11.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(11)
            }
            else{
                btn11.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(11)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
    }
    
    @IBAction func btn12(_ sender: Any) {
        if selected_film != -1
        {
            btn12.isSelected = !btn12.isSelected
            if btn12.isSelected
            {
                btn12.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(12)
            }
            else{
                btn12.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(12)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
        
    }
    
    @IBAction func btn13(_ sender: Any) {
        if selected_film != -1
        {
            btn13.isSelected = !btn13.isSelected
            if btn13.isSelected
            {
                btn13.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(13)
            }
            else{
                btn13.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(13)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
    }
    
    @IBAction func btn14(_ sender: Any) {
        if selected_film != -1
        {
            btn14.isSelected = !btn14.isSelected
            if btn14.isSelected
            {
                btn14.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(14)
            }
            else{
                btn14.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(14)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
    }
    @IBAction func btn15(_ sender: Any) {
        if selected_film != -1
        {
            btn15.isSelected = !btn15.isSelected
            if btn15.isSelected
            {
                btn15.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(15)
            }
            else{
                btn15.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(15)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
    }
    @IBAction func btn16(_ sender: Any) {
        if selected_film != -1
        {
            btn16.isSelected = !btn16.isSelected
            if btn16.isSelected
            {
                btn16.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(16)
            }
            else{
                btn16.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(16)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
    }
    @IBAction func btn17(_ sender: Any) {
        if selected_film != -1
        {
            btn17.isSelected = !btn17.isSelected
            if btn17.isSelected
            {
                btn17.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(17)
            }
            else{
                btn17.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(17)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
    }
    @IBAction func btn21(_ sender: Any) {
        if selected_film != -1
        {
            btn21.isSelected = !btn21.isSelected
            if btn21.isSelected
            {
                btn21.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(21)
            }
            else{
                btn21.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(21)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn22(_ sender: Any) {
        if selected_film != -1
        {
            btn22.isSelected = !btn22.isSelected
            if btn22.isSelected
            {
                btn22.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(22)
            }
            else{
                btn22.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(22)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn23(_ sender: Any) {
        if selected_film != -1
        {
            btn23.isSelected = !btn23.isSelected
            if btn23.isSelected
            {
                btn23.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(23)
            }
            else{
                btn23.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(23)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn24(_ sender: Any) {
        if selected_film != -1
        {
            btn24.isSelected = !btn24.isSelected
            if btn24.isSelected
            {
                btn24.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(24)
            }
            else{
                btn24.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(24)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn25(_ sender: Any) {
        if selected_film != -1
        {
            btn25.isSelected = !btn25.isSelected
            if btn25.isSelected
            {
                btn25.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(25)
            }
            else{
                btn25.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(25)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn26(_ sender: Any) {
        if selected_film != -1
        {
            btn26.isSelected = !btn26.isSelected
            if btn26.isSelected
            {
                btn26.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(26)
            }
            else{
                btn26.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(26)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn27(_ sender: Any) {
        if selected_film != -1
        {
            btn27.isSelected = !btn27.isSelected
            if btn27.isSelected
            {
                btn27.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(27)
            }
            else{
                btn27.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(27)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    
    @IBAction func btn31(_ sender: Any) {
        if selected_film != -1
        {
            btn31.isSelected = !btn31.isSelected
            if btn31.isSelected
            {
                btn31.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(31)
            }
            else{
                btn31.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(31)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn32(_ sender: Any) {
        if selected_film != -1
        {
            btn32.isSelected = !btn32.isSelected
            if btn32.isSelected
            {
                btn32.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(32)
            }
            else{
                btn32.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(32)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn33(_ sender: Any) {
        if selected_film != -1
        {
            btn33.isSelected = !btn33.isSelected
            if btn33.isSelected
            {
                btn33.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(33)
            }
            else{
                btn33.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(33)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    
    @IBAction func btn34(_ sender: Any) {
        if selected_film != -1
        {
            btn34.isSelected = !btn34.isSelected
            if btn34.isSelected
            {
                btn34.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(34)
            }
            else{
                btn34.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(34)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn35(_ sender: Any) {
        if selected_film != -1
        {
            btn35.isSelected = !btn35.isSelected
            if btn35.isSelected
            {
                btn35.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(35)
            }
            else{
                btn35.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(35)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn36(_ sender: Any) {
        if selected_film != -1
        {
            btn36.isSelected = !btn36.isSelected
            if btn36.isSelected
            {
                btn36.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(36)
            }
            else{
                btn36.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(36)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn37(_ sender: Any) {
        if selected_film != -1
        {
            btn37.isSelected = !btn37.isSelected
            if btn37.isSelected
            {
                btn37.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(37)
            }
            else{
                btn37.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(37)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    
    @IBAction func btn41(_ sender: Any) {
        if selected_film != -1
        {
            btn41.isSelected = !btn41.isSelected
            if btn41.isSelected
            {
                btn41.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(41)
            }
            else{
                btn41.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(41)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn42(_ sender: Any) {
        if selected_film != -1
        {
            btn42.isSelected = !btn42.isSelected
            if btn42.isSelected
            {
                btn42.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(42)
            }
            else{
                btn42.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(41)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn43(_ sender: Any) {
        if selected_film != -1
        {
            btn43.isSelected = !btn43.isSelected
            if btn43.isSelected
            {
                btn43.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(43)
            }
            else{
                btn43.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(43)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn44(_ sender: Any) {
        if selected_film != -1
        {
            btn44.isSelected = !btn44.isSelected
            if btn44.isSelected
            {
                btn44.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(44)
            }
            else{
                btn44.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(44)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn45(_ sender: Any) {
        if selected_film != -1
        {
            btn45.isSelected = !btn45.isSelected
            if btn45.isSelected
            {
                btn45.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(45)
            }
            else{
                btn45.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(45)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn46(_ sender: Any) {
        if selected_film != -1
        {
            btn46.isSelected = !btn46.isSelected
            if btn46.isSelected
            {
                btn46.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(46)
            }
            else{
                btn46.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(46)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn47(_ sender: Any) {
        if selected_film != -1
        {
            btn47.isSelected = !btn47.isSelected
            if btn47.isSelected
            {
                btn47.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(47)
            }
            else{
                btn47.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(47)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn51(_ sender: Any) {
        if selected_film != -1
        {
            btn51.isSelected = !btn51.isSelected
            if btn51.isSelected
            {
                btn51.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(51)
            }
            else{
                btn51.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(51)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn52(_ sender: Any) {
        if selected_film != -1
        {
            btn52.isSelected = !btn52.isSelected
            if btn52.isSelected
            {
                btn52.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(52)
            }
            else{
                btn52.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(52)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn53(_ sender: Any) {
        if selected_film != -1
        {
            btn53.isSelected = !btn53.isSelected
            if btn53.isSelected
            {
                btn53.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(53)
            }
            else{
                btn53.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(53)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn54(_ sender: Any) {
        if selected_film != -1
        {
            btn54.isSelected = !btn54.isSelected
            if btn54.isSelected
            {
                btn54.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(54)
            }
            else{
                btn54.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(54)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn55(_ sender: Any) {
        if selected_film != -1
        {
            btn55.isSelected = !btn55.isSelected
            if btn55.isSelected
            {
                btn55.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(55)
            }
            else{
                btn55.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(55)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn56(_ sender: Any) {
        if selected_film != -1
        {
            btn56.isSelected = !btn56.isSelected
            if btn56.isSelected
            {
                btn56.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(56)
            }
            else{
                btn56.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(56)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn57(_ sender: Any) {
        if selected_film != -1
        {
            btn57.isSelected = !btn57.isSelected
            if btn57.isSelected
            {
                btn57.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(57)
            }
            else{
                btn57.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(57)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn61(_ sender: Any) {
        if selected_film != -1
        {
            btn61.isSelected = !btn61.isSelected
            if btn61.isSelected
            {
                btn61.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(61)
            }
            else{
                btn61.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(61)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn62(_ sender: Any) {
        if selected_film != -1
        {
            btn62.isSelected = !btn62.isSelected
            if btn62.isSelected
            {
                btn62.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(62)
            }
            else{
                btn62.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(62)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn63(_ sender: Any) {
        if selected_film != -1
        {
            btn63.isSelected = !btn63.isSelected
            if btn63.isSelected
            {
                btn63.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(63)
            }
            else{
                btn63.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(63)
                
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn64(_ sender: Any) {
        if selected_film != -1
        {
            btn64.isSelected = !btn64.isSelected
            if btn64.isSelected
            {
                btn64.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(64)
            }
            else{
                btn64.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(64)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn65(_ sender: Any) {
        if selected_film != -1
        {
            btn65.isSelected = !btn65.isSelected
            if btn65.isSelected
            {
                btn65.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(65)
            }
            else{
                btn65.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(65)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn66(_ sender: Any) {
        if selected_film != -1
        {
            btn66.isSelected = !btn66.isSelected
            if btn66.isSelected
            {
                btn66.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(66)
            }
            else{
                btn66.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(66)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    @IBAction func btn67(_ sender: Any) {
        if selected_film != -1
        {
            btn67.isSelected = !btn67.isSelected
            if btn67.isSelected
            {
                btn67.setImage(UIImage(named: "reserved.png")!, for: .normal)
                st_seats += 1
                label_seats.text = String(st_seats)
                sedeziVstavi.insert(67)
            }
            else{
                btn67.setImage(UIImage(named: "free.png")!, for: .normal)
                st_seats -= 1
                label_seats.text = String(st_seats)
                sedeziVstavi.remove(67)
            }
        }
        if st_seats > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
    }
    
    
    
    
    
    func disableAll(){
        btn11.isEnabled = false
        btn11.alpha = 0.5
        btn12.isEnabled = false
        btn12.alpha = 1
        btn13.isEnabled = false
        btn13.alpha = 1
        btn14.isEnabled = false
        btn14.alpha = 1
        btn15.isEnabled = false
        btn15.alpha = 1
        btn16.isEnabled = false
        btn16.alpha = 1
        btn17.isEnabled = false
        btn17.alpha = 1
        
        btn21.isEnabled = false
        btn21.alpha = 1
        btn22.isEnabled = false
        btn22.alpha = 1
        btn23.isEnabled = false
        btn23.alpha = 1
        btn24.isEnabled = false
        btn24.alpha = 1
        btn25.isEnabled = false
        btn25.alpha = 1
        btn26.isEnabled = false
        btn26.alpha = 1
        btn27.isEnabled = false
        btn27.alpha = 1
        
        btn31.isEnabled = false
        btn31.alpha = 1
        btn32.isEnabled = false
        btn32.alpha = 1
        btn33.isEnabled = false
        btn33.alpha = 1
        btn34.isEnabled = false
        btn34.alpha = 1
        btn35.isEnabled = false
        btn35.alpha = 1
        btn36.isEnabled = false
        btn36.alpha = 1
        btn37.isEnabled = false
        btn37.alpha = 1
        
        btn41.isEnabled = false
        btn41.alpha = 1
        btn42.isEnabled = false
        btn42.alpha = 1
        btn43.isEnabled = false
        btn43.alpha = 1
        btn44.isEnabled = false
        btn44.alpha = 1
        btn45.isEnabled = false
        btn45.alpha = 1
        btn46.isEnabled = false
        btn46.alpha = 1
        btn47.isEnabled = false
        btn47.alpha = 1
        
        btn51.isEnabled = false
        btn51.alpha = 1
        btn52.isEnabled = false
        btn52.alpha = 1
        btn53.isEnabled = false
        btn53.alpha = 1
        btn54.isEnabled = false
        btn54.alpha = 1
        btn55.isEnabled = false
        btn55.alpha = 1
        btn56.isEnabled = false
        btn56.alpha = 1
        btn57.isEnabled = false
        btn57.alpha = 1
        
        btn61.isEnabled = false
        btn61.alpha = 1
        btn62.isEnabled = false
        btn62.alpha = 1
        btn63.isEnabled = false
        btn63.alpha = 1
        btn64.isEnabled = false
        btn64.alpha = 1
        btn65.isEnabled = false
        btn65.alpha = 1
        btn66.isEnabled = false
        btn66.alpha = 1
        btn67.isEnabled = false
        btn67.alpha = 1
    }
    
    
    
    
    
    
    
    
    
    func enableAll(){
        btn11.isEnabled = true
        btn11.alpha = 1
        btn12.isEnabled = true
        btn12.alpha = 1
        btn13.isEnabled = true
        btn13.alpha = 1
        btn14.isEnabled = true
        btn14.alpha = 1
        btn15.isEnabled = true
        btn15.alpha = 1
        btn16.isEnabled = true
        btn16.alpha = 1
        btn17.isEnabled = true
        btn17.alpha = 1
        
        btn21.isEnabled = true
        btn21.alpha = 1
        btn22.isEnabled = true
        btn22.alpha = 1
        btn23.isEnabled = true
        btn23.alpha = 1
        btn24.isEnabled = true
        btn24.alpha = 1
        btn25.isEnabled = true
        btn25.alpha = 1
        btn26.isEnabled = true
        btn26.alpha = 1
        btn27.isEnabled = true
        btn27.alpha = 1
        
        btn31.isEnabled = true
        btn31.alpha = 1
        btn32.isEnabled = true
        btn32.alpha = 1
        btn33.isEnabled = true
        btn33.alpha = 1
        btn34.isEnabled = true
        btn34.alpha = 1
        btn35.isEnabled = true
        btn35.alpha = 1
        btn36.isEnabled = true
        btn36.alpha = 1
        btn37.isEnabled = true
        btn37.alpha = 1
        
        btn41.isEnabled = true
        btn41.alpha = 1
        btn42.isEnabled = true
        btn42.alpha = 1
        btn43.isEnabled = true
        btn43.alpha = 1
        btn44.isEnabled = true
        btn44.alpha = 1
        btn45.isEnabled = true
        btn45.alpha = 1
        btn46.isEnabled = true
        btn46.alpha = 1
        btn47.isEnabled = true
        btn47.alpha = 1
        
        btn51.isEnabled = true
        btn51.alpha = 1
        btn52.isEnabled = true
        btn52.alpha = 1
        btn53.isEnabled = true
        btn53.alpha = 1
        btn54.isEnabled = true
        btn54.alpha = 1
        btn55.isEnabled = true
        btn55.alpha = 1
        btn56.isEnabled = true
        btn56.alpha = 1
        btn57.isEnabled = true
        btn57.alpha = 1
        
        btn61.isEnabled = true
        btn61.alpha = 1
        btn62.isEnabled = true
        btn62.alpha = 1
        btn63.isEnabled = true
        btn63.alpha = 1
        btn64.isEnabled = true
        btn64.alpha = 1
        btn65.isEnabled = true
        btn65.alpha = 1
        btn66.isEnabled = true
        btn66.alpha = 1
        btn67.isEnabled = true
        btn67.alpha = 1
    }
    
    func reserved(id_filma:Int){

        
        
        izbraniTermini = []
        indexTermini = []
        for r in terminCollection{
            if r.idfilm == id_filma
            {
                let d_format = DateFormatter()
                d_format.dateFormat = "dd.MM.yyyy HH:mm"
                let a = d_format.string(from: r.cas)
                if !izbraniTermini.contains(a)
                {
                    let d_format = DateFormatter()
                    d_format.dateFormat = "dd.MM.yyyy HH:mm"
                    let a = d_format.string(from: r.cas)
                    izbraniTermini.append(a)
                    indexTermini.append(r.id_termin)
                }
            }
        }
        picker.reloadAllComponents()
        
        
        for r in rezervacijaCollection{
            for t in terminCollection{
                let d_format = DateFormatter()
                d_format.dateFormat = "dd.MM.yyyy HH:mm"
                let a = d_format.string(from: t.cas)
                if r.idTermin == izbrTerminIndex && a == izbrTermin{
                    switch r.idSedez{
                    case 11:
                        btn11.isEnabled = false
  
                        break
                    case 12:
                        btn12.isEnabled = false
                        
                        break
                    case 13:
                        btn13.isEnabled = false
                        
                        break
                    case 14:
                        btn14.isEnabled = false
                        
                        break
                    case 15:
                        btn15.isEnabled = false
                        
                        break
                    case 16:
                        btn16.isEnabled = false
                        
                        break
                    case 17:
                        btn17.isEnabled = false
                        
                        break
                    case 21:
                        btn21.isEnabled = false
                        
                        break
                    case 22:
                        btn22.isEnabled = false
                        
                        break
                    case 23:
                        btn23.isEnabled = false
                        
                        break
                    case 24:
                        btn24.isEnabled = false
                        
                        break
                    case 25:
                        btn25.isEnabled = false
                        
                        break
                    case 26:
                        btn26.isEnabled = false
                        
                        break
                    case 27:
                        btn27.isEnabled = false
                        
                        break
                    case 31:
                        btn31.isEnabled = false
                        
                        break
                    case 32:
                        btn32.isEnabled = false
                        
                        break
                    case 33:
                        btn33.isEnabled = false
                        
                        break
                    case 34:
                        btn34.isEnabled = false
                        
                        break
                    case 35:
                        btn35.isEnabled = false
                        
                        break
                    case 36:
                        btn36.isEnabled = false
                        
                        break
                    case 37:
                        btn37.isEnabled = false
                        
                        break
                    case 41:
                        btn41.isEnabled = false
                        
                        break
                    case 42:
                        btn42.isEnabled = false
                        
                        break
                    case 43:
                        btn43.isEnabled = false
                        
                        break
                    case 44:
                        btn44.isEnabled = false
                        
                        break
                    case 45:
                        btn45.isEnabled = false
                        
                        break
                    case 46:
                        btn46.isEnabled = false
                        
                        break
                    case 47:
                        btn47.isEnabled = false
                        
                        break
                    case 51:
                        btn51.isEnabled = false
                        
                        break
                    case 52:
                        btn52.isEnabled = false
                        
                        break
                        
                    case 53:
                        btn53.isEnabled = false
                        
                        break
                    case 54:
                        btn54.isEnabled = false
                        
                        break
                    case 55:
                        btn55.isEnabled = false
                        
                        break
                    case 56:
                        btn56.isEnabled = false
                        
                        break
                    case 57:
                        btn57.isEnabled = false
                        
                        break
                    case 61:
                        btn61.isEnabled = false
                        
                        break
                    case 62:
                        btn62.isEnabled = false
                        
                        break
                    case 63:
                        btn63.isEnabled = false
                        
                        break
                    case 64:
                        btn64.isEnabled = false
                        
                        break
                    case 65:
                        btn65.isEnabled = false
                        
                        break
                    case 66:
                        btn66.isEnabled = false
                        
                        break
                    case 67:
                        btn67.isEnabled = false
                        
                        break
                    default:
                        print("napaka")
                    }
                }
            }
        }
        
    }
    
    
    var service:FilmService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        terminCollection = []
        filmCollection = []
        rezervacijaCollection = []
        sedeziVstavi = []
        data = []
        subtitles = []
        slike = []
        indexTermini = []
        st_seats = 0
        label_seats.text = "Seats"
        cena = 0
        btn_pay.setTitle("PAY", for: .normal)
        label_movie.text = "Movie"
        label_check.text = ""
        
        //print("AA")
        
        btn_pay.isEnabled = false
        btn_pay.alpha = 0.5
        
        
        
        service = FilmService()
        service.getFilms {
            (response) in
            loadFilms(films: response as! Array<NSDictionary>)
        }
        
        service.getTermini() {
            (response) in
            loadTermins(termins: response as! Array<NSDictionary>)
        }
        
        
        service.getRezervacija() {
            (response) in
            loadRezervacija(rezervacijas: response as! Array<NSDictionary>)
        }
        
        func loadRezervacija(rezervacijas:Array<NSDictionary>) {
            for rezervacija in rezervacijas {
                let id = rezervacija["idSedezRezervacija"]! as! Int
                let statusSedeza = rezervacija["statusSedeza"]! as! Bool
                let idSedez = rezervacija["idSedez"]! as! Int
                let idRezervacija = rezervacija["idRezervacija"]! as! Int
                let idTermin = rezervacija["idTermin"]! as! Int
                
                let rezervacijaObj = Rezervacija(idSedezRezervacija: id, statusSedeza: statusSedeza, idRezervacija: idRezervacija, idSedez: idSedez, idTermin: idTermin)
                rezervacijaCollection.append(rezervacijaObj)
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(rezervacijaCollection[rezervacijaCollection.count-1].idSedezRezervacija)
                
                
            }
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
                
                filmCollection.append(filmObj)
                data.append(naslov)
                subtitles.append(opis)
                
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                
                //self.naslovLabel.text = filmCollection[1].naslov
                //self.opisLabel.text = filmCollection[1].opis
                //print(filmCollection[1].naslov)
                
            }
            
        }
        
        func loadTermins(termins:Array<NSDictionary>) {
            for termin in termins {
                let id = termin["idTermin"]! as! Int
                let dataformatter = DateFormatter()
                dataformatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss"
                let cas = dataformatter.date(from: termin["cas"]! as! String)!
                let idFilm = termin["idFilm"]! as! Int
                let terminObj = Termin(id_termin: id, cas: cas, idfilm: idFilm)
                
                terminCollection.append(terminObj)
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.enableAll()
                self.reserved(id_filma: id_filma)
            }
        }
        
        
        
    }
    
    
    
    
    @IBAction func btn_check(_ sender: Any) {
        
        sedezi_check = []
        set_btn_false_free()
        viewDidLoad()
        
        sleep(1)
        var count = 0
        let vnos = textfield_check.text
        label_check.text = "No exist"
        for r in rezervacijaCollection{
            if vnos == String(r.idRezervacija){
                label_check.text = "Exist"
            }
        }
        for rs in rezervacijaCollection{
            if String(rs.idRezervacija) == vnos{
                count += 1
                sedezi_check.append(rs.idSedez)
            }
        }
        label_check.text = "Seats: " + String(count)
        
        for s in sedezi_check{
            switch s{
            case 11:
                btn11.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn11.alpha = 1
                
                
                break
            case 12:
                
                btn12.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn12.alpha = 1
                
                
                break
            case 13:
                btn13.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn13.alpha = 1
                
                
                break
            case 14:
                btn14.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn14.alpha = 1
               
                
                break
            case 15:
                btn15.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn15.alpha = 1
                
                
                break
            case 16:
                btn16.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn16.alpha = 1
                
                
                break
            case 17:
                btn17.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn17.alpha = 1
                
            case 21:
                btn21.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn21.alpha = 1
                
                
                break
            case 22:
                
                btn22.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn22.alpha = 1
                
                
                break
            case 23:
                btn23.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn23.alpha = 1
                
                
                break
            case 24:
                btn24.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn24.alpha = 1
                
                
                break
            case 25:
                btn25.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn25.alpha = 1
                
                
                break
            case 26:
                btn26.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn26.alpha = 1
                
                
                break
            case 27:
                btn27.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn27.alpha = 1
                break
            case 31:
                btn31.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn31.alpha = 1
                
                
                break
            case 32:
                
                btn32.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn32.alpha = 1
                
                
                break
            case 33:
                btn33.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn33.alpha = 1
                
                
                break
            case 34:
                btn34.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn34.alpha = 1
                
                
                break
            case 35:
                btn35.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn35.alpha = 1
                
                
                break
            case 36:
                btn36.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn36.alpha = 1
                
                
                break
            case 37:
                btn37.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn37.alpha = 1
                
                break
            case 41:
                btn41.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn41.alpha = 1
                
                
                break
            case 42:
                
                btn42.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn42.alpha = 1
                
                
                break
            case 43:
                btn43.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn43.alpha = 1
                
                
                break
            case 44:
                btn44.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn44.alpha = 1
                
                
                break
            case 45:
                btn45.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn45.alpha = 1
                
                
                break
            case 46:
                btn46.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn46.alpha = 1
                
                
                break
            case 47:
                btn47.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn47.alpha = 1
                
                break
            case 51:
                btn51.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn51.alpha = 1
                
                
                break
            case 52:
                
                btn52.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn52.alpha = 1
                
                
                break
            case 53:
                btn53.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn53.alpha = 1
                
                
                break
            case 54:
                btn54.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn54.alpha = 1
                
                
                break
            case 55:
                btn55.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn55.alpha = 1
                
                
                break
            case 56:
                btn56.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn56.alpha = 1
                
                
                break
            case 57:
                btn57.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn57.alpha = 1
                
                break
            case 61:
                btn61.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn61.alpha = 1
                
                
                break
            case 62:
                
                btn62.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn62.alpha = 1
                
                
                break
            case 63:
                btn63.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn63.alpha = 1
                
                
                break
            case 64:
                btn64.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn64.alpha = 1
                
                
                break
            case 65:
                btn65.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn65.alpha = 1
                
                
                break
            case 66:
                btn66.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn66.alpha = 1
                
                
                break
            case 67:
                btn67.setImage(UIImage(named: "reserved.png")!, for: .normal)
                btn67.alpha = 1
                
                break
            default:
                break
            }
        }
        
        if count > 0{
            btn_pay.isEnabled = true
            btn_pay.alpha = 1
        }
        else{
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        let v = Double(count) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //viewDidLoad()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        cell?.lbl_naslov.text = data[indexPath.row]
        cell?.lbl_opis.text = subtitles[indexPath.row]
        cell?.img.image = UIImage(named: data[indexPath.row])
        
        //picker.selectRow(0, inComponent: 0, animated: true)
        
        //enableAll()
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //picker.selectedRow(inComponent: 0)
        selected_film = indexPath.row
        set_btn_false_free()
        st_seats = 0
        label_seats.text = String(st_seats)
        let v = Double(st_seats) * 7.20
        btn_pay.setTitle("Pay " + String(v) + " €", for: .normal)
        if (v == 0.0)
        {
            btn_pay.setTitle("Pay", for: .normal)
            btn_pay.isEnabled = false
            btn_pay.alpha = 0.5
        }
        
        
        //let indexTermin:Int = -1
        for t in terminCollection{
            if t.idfilm == selected_film
            {
                let d_format = DateFormatter()
                d_format.dateFormat = "dd.MM.yyyy"
                //label_termin.text = d_format.string(from: t.cas)
                
                let u_format = DateFormatter()
                u_format.dateFormat = "HH:mm"
                //label_ura.text = u_format.string(from: t.cas)
                //indexTermin = t.id_termin
                //print(indexTermin)
            }
        }
        id_filma = -1
        //for f in filmCollection{
        //if f.id_film == selected_film{
        label_movie.text = filmCollection[selected_film].naslov
        id_filma = filmCollection[selected_film].id_film
        //}
        //}
        enableAll()
        //picker.selectRow(0, inComponent: 0, animated: true)
        reserved(id_filma: id_filma)
        picker.isHidden = false
        self.picker.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(picker, didSelectRow: 0, inComponent: 0)
        label_check.text = ""
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return izbraniTermini.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return izbraniTermini[row]
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: izbraniTermini[row], attributes: [.foregroundColor: UIColor.lightGray])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        izbrTermin = izbraniTermini[row]
        izbrTerminIndex = indexTermini[row]
        enableAll()
        reserved(id_filma: id_filma)
        //print(izbrTermin)
        //print(izbrTerminIndex)
        //reserved(index: indexPicker[row])
    }
    
    
    func getData(){
        
        terminCollection = []
        filmCollection = []
        rezervacijaCollection = []
        sedeziVstavi = []
        data = []
        subtitles = []
        slike = []
        indexTermini = []
        st_seats = 0
        label_seats.text = "Seats"
        cena = 0
        btn_pay.setTitle("PAY", for: .normal)
        label_movie.text = "Movie"
        label_check.text = ""
        
        service = FilmService()
        service.getFilms {
            (response) in
            loadFilms(films: response as! Array<NSDictionary>)
        }
        
        service.getTermini() {
            (response) in
            loadTermins(termins: response as! Array<NSDictionary>)
        }
        
        
        service.getRezervacija() {
            (response) in
            loadRezervacija(rezervacijas: response as! Array<NSDictionary>)
        }
        
        func loadRezervacija(rezervacijas:Array<NSDictionary>) {
            for rezervacija in rezervacijas {
                let id = rezervacija["idSedezRezervacija"]! as! Int
                let statusSedeza = rezervacija["statusSedeza"]! as! Bool
                let idSedez = rezervacija["idSedez"]! as! Int
                let idRezervacija = rezervacija["idRezervacija"]! as! Int
                let idTermin = rezervacija["idTermin"]! as! Int
                
                let rezervacijaObj = Rezervacija(idSedezRezervacija: id, statusSedeza: statusSedeza, idRezervacija: idRezervacija, idSedez: idSedez, idTermin: idTermin)
                rezervacijaCollection.append(rezervacijaObj)
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(rezervacijaCollection[rezervacijaCollection.count-1].idSedezRezervacija)
                
                
            }
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
                
                filmCollection.append(filmObj)
                data.append(naslov)
                subtitles.append(opis)
                
            }
            
            DispatchQueue.main.async {
                print(filmCollection)
                self.tableView.reloadData()
                
                
                //self.naslovLabel.text = filmCollection[1].naslov
                //self.opisLabel.text = filmCollection[1].opis
                //print(filmCollection[1].naslov)
                
            }
            
        }
        
        func loadTermins(termins:Array<NSDictionary>) {
            for termin in termins {
                let id = termin["idTermin"]! as! Int
                let dataformatter = DateFormatter()
                dataformatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss"
                let cas = dataformatter.date(from: termin["cas"]! as! String)!
                let idFilm = termin["idFilm"]! as! Int
                let terminObj = Termin(id_termin: id, cas: cas, idfilm: idFilm)
                
                terminCollection.append(terminObj)
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.enableAll()
                self.reserved(id_filma: id_filma)
            }
        }
    }
}

