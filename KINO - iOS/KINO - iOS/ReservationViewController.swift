//
//  ReservationViewController.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 29/04/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import UIKit

var sedezi:Set<Int> = []
var izbranDatum:String = ""


class ReservationViewController: UIViewController {
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //ROW 1
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    
    //ROW 2
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    @IBOutlet weak var button25: UIButton!
    @IBOutlet weak var button26: UIButton!
    @IBOutlet weak var button27: UIButton!
    
    //ROW 3
    @IBOutlet weak var button31: UIButton!
    @IBOutlet weak var button32: UIButton!
    @IBOutlet weak var button33: UIButton!
    @IBOutlet weak var button34: UIButton!
    @IBOutlet weak var button35: UIButton!
    @IBOutlet weak var button36: UIButton!
    @IBOutlet weak var button37: UIButton!
    
    //ROW 4
    @IBOutlet weak var button41: UIButton!
    @IBOutlet weak var button42: UIButton!
    @IBOutlet weak var button43: UIButton!
    @IBOutlet weak var button44: UIButton!
    @IBOutlet weak var button45: UIButton!
    @IBOutlet weak var button46: UIButton!
    @IBOutlet weak var button47: UIButton!
    
    //ROW 5
    @IBOutlet weak var button51: UIButton!
    @IBOutlet weak var button52: UIButton!
    @IBOutlet weak var button53: UIButton!
    @IBOutlet weak var button54: UIButton!
    @IBOutlet weak var button55: UIButton!
    @IBOutlet weak var button56: UIButton!
    @IBOutlet weak var button57: UIButton!
    
    //ROW 6
    @IBOutlet weak var button61: UIButton!
    @IBOutlet weak var button62: UIButton!
    @IBOutlet weak var button63: UIButton!
    @IBOutlet weak var button64: UIButton!
    @IBOutlet weak var button65: UIButton!
    @IBOutlet weak var button66: UIButton!
    @IBOutlet weak var button67: UIButton!
    
    
    
    
    let imageReserved = UIImage(named: "reserved.png")
    let imageFree = UIImage(named: "free.png")
    var price = 0.00
    var index = 0
    var indexTermin = 0
    
    var pickerData:[String] = [String]()
    var indexPicker:[Int] = [Int]()
    
    
    let dateFormatter = DateFormatter()
    
    var cas:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sedezi.removeAll()
        navigationController?.setNavigationBarHidden(true, animated: true)
        reserveButton.isEnabled = false
        
        izbranDatum = ""
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        for termin in terminCollection{
            if termin.idFilm == filmCollection[index].id_film {
                pickerData.append(termin.cas)
                indexPicker.append(termin.idTermin)
            }
        }
        
        if (pickerData.count == 0){
            let alert = UIAlertController(title: "Reservation impossible", message: "There is no available dates for this movie", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Return to home screen"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
        
        for termin in terminCollection {
            if termin.idFilm == filmCollection[index].id_film{
                reserved(index: termin.idTermin)
                break
            }
        }
        
        
        titleLabel.text = (filmCollection[index].naslov).uppercased()
    }
    
    func reserved(index:Int){
        enableAll()
        for row in rezervacijaCollection{
            if row.idTermin == index{
                switch row.idSedez {
                case 11:
                    button11.isEnabled = false
                    button11.alpha = 0.5
                case 12:
                    button12.isEnabled = false
                    button12.alpha = 0.5
                case 13:
                    button13.isEnabled = false
                    button13.alpha = 0.5
                case 14:
                    button14.isEnabled = false
                    button14.alpha = 0.5
                case 15:
                    button15.isEnabled = false
                    button15.alpha = 0.5
                case 16:
                    button16.isEnabled = false
                    button16.alpha = 0.5
                case 17:
                    button17.isEnabled = false
                    button17.alpha = 0.5
                case 21:
                    button21.isEnabled = false
                    button21.alpha = 0.5
                case 22:
                    button22.isEnabled = false
                    button22.alpha = 0.5
                case 23:
                    button23.isEnabled = false
                    button23.alpha = 0.5
                case 24:
                    button24.isEnabled = false
                    button24.alpha = 0.5
                case 25:
                    button25.isEnabled = false
                    button25.alpha = 0.5
                case 26:
                    button26.isEnabled = false
                    button26.alpha = 0.5
                case 27:
                    button27.isEnabled = false
                    button27.alpha = 0.5
                case 31:
                    button31.isEnabled = false
                    button31.alpha = 0.5
                case 32:
                    button32.isEnabled = false
                    button32.alpha = 0.5
                case 33:
                    button33.isEnabled = false
                    button33.alpha = 0.5
                case 34:
                    button34.isEnabled = false
                    button34.alpha = 0.5
                case 35:
                    button35.isEnabled = false
                    button35.alpha = 0.5
                case 36:
                    button36.isEnabled = false
                    button36.alpha = 0.5
                case 37:
                    button37.isEnabled = false
                    button37.alpha = 0.5
                case 41:
                    button41.isEnabled = false
                    button41.alpha = 0.5
                case 42:
                    button42.isEnabled = false
                    button42.alpha = 0.5
                case 43:
                    button43.isEnabled = false
                    button43.alpha = 0.5
                case 44:
                    button44.isEnabled = false
                    button44.alpha = 0.5
                case 45:
                    button45.isEnabled = false
                    button45.alpha = 0.5
                case 46:
                    button46.isEnabled = false
                    button46.alpha = 0.5
                case 47:
                    button47.isEnabled = false
                    button47.alpha = 0.5
                case 51:
                    button51.isEnabled = false
                    button51.alpha = 0.5
                case 52:
                    button52.isEnabled = false
                    button52.alpha = 0.5
                case 53:
                    button53.isEnabled = false
                    button53.alpha = 0.5
                case 54:
                    button54.isEnabled = false
                    button54.alpha = 0.5
                case 55:
                    button55.isEnabled = false
                    button55.alpha = 0.5
                case 56:
                    button56.isEnabled = false
                    button56.alpha = 0.5
                case 57:
                    button57.isEnabled = false
                    button57.alpha = 0.5
                case 61:
                    button61.isEnabled = false
                    button61.alpha = 0.5
                case 62:
                    button62.isEnabled = false
                    button62.alpha = 0.5
                case 63:
                    button63.isEnabled = false
                    button63.alpha = 0.5
                case 64:
                    button64.isEnabled = false
                    button64.alpha = 0.5
                case 65:
                    button65.isEnabled = false
                    button65.alpha = 0.5
                case 66:
                    button66.isEnabled = false
                    button66.alpha = 0.5
                case 67:
                    button67.isEnabled = false
                    button67.alpha = 0.5
                default:
                    break
                }
            }
        }
    }
    
    func enableAll(){
        button11.isEnabled = true
        button11.alpha = 1
        button12.isEnabled = true
        button12.alpha = 1
        button13.isEnabled = true
        button13.alpha = 1
        button14.isEnabled = true
        button14.alpha = 1
        button15.isEnabled = true
        button15.alpha = 1
        button16.isEnabled = true
        button16.alpha = 1
        button17.isEnabled = true
        button17.alpha = 1
        
        button21.isEnabled = true
        button21.alpha = 1
        button22.isEnabled = true
        button22.alpha = 1
        button23.isEnabled = true
        button23.alpha = 1
        button24.isEnabled = true
        button24.alpha = 1
        button25.isEnabled = true
        button25.alpha = 1
        button26.isEnabled = true
        button26.alpha = 1
        button27.isEnabled = true
        button27.alpha = 1
        
        button31.isEnabled = true
        button31.alpha = 1
        button32.isEnabled = true
        button32.alpha = 1
        button33.isEnabled = true
        button33.alpha = 1
        button34.isEnabled = true
        button34.alpha = 1
        button35.isEnabled = true
        button35.alpha = 1
        button36.isEnabled = true
        button36.alpha = 1
        button37.isEnabled = true
        button37.alpha = 1
        
        button41.isEnabled = true
        button41.alpha = 1
        button42.isEnabled = true
        button42.alpha = 1
        button43.isEnabled = true
        button43.alpha = 1
        button44.isEnabled = true
        button44.alpha = 1
        button45.isEnabled = true
        button45.alpha = 1
        button46.isEnabled = true
        button46.alpha = 1
        button47.isEnabled = true
        button47.alpha = 1
        
        button51.isEnabled = true
        button51.alpha = 1
        button52.isEnabled = true
        button52.alpha = 1
        button53.isEnabled = true
        button53.alpha = 1
        button54.isEnabled = true
        button54.alpha = 1
        button55.isEnabled = true
        button55.alpha = 1
        button56.isEnabled = true
        button56.alpha = 1
        button57.isEnabled = true
        button57.alpha = 1
        
        button61.isEnabled = true
        button61.alpha = 1
        button62.isEnabled = true
        button62.alpha = 1
        button63.isEnabled = true
        button63.alpha = 1
        button64.isEnabled = true
        button64.alpha = 1
        button65.isEnabled = true
        button65.alpha = 1
        button66.isEnabled = true
        button66.alpha = 1
        button67.isEnabled = true
        button67.alpha = 1
    }
    
    @IBAction func reservePressed(_ sender: Any) {
        if (price > 0){
            var id = Int.random(in: 100000 ... 1000000)
            for object in rezervacijaCollection {
                if object.idRezervacija == id {
                    id = Int.random(in: 100000 ... 1000000)
                }
            }
            
            for termin in terminCollection {
                if termin.cas == izbranDatum {
                    indexTermin = termin.idTermin
                    break
                }
            }
            
            if izbranDatum == ""{
                for termin in terminCollection {
                    if termin.idFilm  == filmCollection[index].id_film{
                        indexTermin = termin.idTermin
                        break
                    }
                }
            }
            
            for sedez in sedezi {
                let myURL = URL(string: "https://cinemauv.azurewebsites.net/api/Rezervacija")
                var request = URLRequest(url: myURL!)
                request.httpMethod = "POST"
                let parameters: [String:Any?] = [
                    "statusSedeza": true,
                    "idSedez": sedez,
                    "idRezervacija": id,
                    "idTermin": indexTermin,
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
            
            
            let successful = self.storyboard?.instantiateViewController(withIdentifier: "Successful") as! SuccessfulViewController
            successful.idRezervacija = id
            self.navigationController?.pushViewController(successful, animated: true)
            
        }

    }
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //ROW 1
    @IBAction func button11Pressed(_ sender: Any) {
        button11.isSelected = !button11.isSelected
        if (button11.isSelected) {
            price += 7.20
            button11.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(11)
            
        }
        else {
            price -= 7.20
            button11.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(11)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    @IBAction func button12Pressed(_ sender: Any) {
        button12.isSelected = !button12.isSelected
        if (button12.isSelected) {
            price += 7.20
            button12.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(12)
        }
        else {
            price -= 7.20
            button12.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(12)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    @IBAction func button13Pressed(_ sender: Any) {
        button13.isSelected = !button13.isSelected
        if (button13.isSelected) {
            price += 7.20
            button13.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(13)
        }
        else {
            price -= 7.20
            button13.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(13)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    @IBAction func Button14Pressed(_ sender: Any) {
        button14.isSelected = !button14.isSelected
        if (button14.isSelected) {
            price += 7.20
            button14.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(14)
        }
        else {
            price -= 7.20
            button14.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(14)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    @IBAction func button15Pressed(_ sender: Any) {
        button15.isSelected = !button15.isSelected
        if (button15.isSelected) {
            price += 7.20
            button15.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(15)
        }
        else {
            price -= 7.20
            button15.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(15)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    @IBAction func button16Pressed(_ sender: Any) {
        button16.isSelected = !button16.isSelected
        if (button16.isSelected) {
            price += 7.20
            button16.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(16)
        }
        else {
            price -= 7.20
            button16.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(16)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    @IBAction func button17Pressed(_ sender: Any) {
        button17.isSelected = !button17.isSelected
        if (button17.isSelected) {
            price += 7.20
            button17.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(17)
        }
        else {
            price -= 7.20
            button17.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(17)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    
    //ROW 2
    @IBAction func button21Pressed(_ sender: Any) {
        button21.isSelected = !button21.isSelected
        if (button21.isSelected) {
            price += 7.20
            button21.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(21)
        }
        else {
            price -= 7.20
            button21.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(21)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button22Pressed(_ sender: Any) {
        button22.isSelected = !button22.isSelected
        if (button22.isSelected) {
            price += 7.20
            button22.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(22)
        }
        else {
            price -= 7.20
            button22.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(22)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button23Pressed(_ sender: Any) {
        button23.isSelected = !button23.isSelected
        if (button23.isSelected) {
            price += 7.20
            button23.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(23)
        }
        else {
            price -= 7.20
            button23.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(23)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button24Pressed(_ sender: Any) {
        button24.isSelected = !button24.isSelected
        if (button24.isSelected) {
            price += 7.20
            button24.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(24)
        }
        else {
            price -= 7.20
            button24.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(24)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button25Pressed(_ sender: Any) {
        button25.isSelected = !button25.isSelected
        if (button25.isSelected) {
            price += 7.20
            button25.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(25)
        }
        else {
            price -= 7.20
            button25.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(25)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button26Pressed(_ sender: Any) {
        button26.isSelected = !button26.isSelected
        if (button26.isSelected) {
            price += 7.20
            button26.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(26)
        }
        else {
            price -= 7.20
            button26.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(26)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button27Pressed(_ sender: Any) {
        button27.isSelected = !button27.isSelected
        if (button27.isSelected) {
            price += 7.20
            button27.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(27)
        }
        else {
            price -= 7.20
            button27.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(27)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button31Pressed(_ sender: Any) {
        button31.isSelected = !button31.isSelected
        if (button31.isSelected) {
            price += 7.20
            button31.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(31)
        }
        else {
            price -= 7.20
            button31.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(31)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button32Pressed(_ sender: Any) {
        button32.isSelected = !button32.isSelected
        if (button32.isSelected) {
            price += 7.20
            button32.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(32)
        }
        else {
            price -= 7.20
            button32.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(32)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button33Pressed(_ sender: Any) {
        button33.isSelected = !button33.isSelected
        if (button33.isSelected) {
            price += 7.20
            button33.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(33)
        }
        else {
            price -= 7.20
            button33.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(33)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button34Pressed(_ sender: Any) {
        button34.isSelected = !button34.isSelected
        if (button34.isSelected) {
            price += 7.20
            button34.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(34)
        }
        else {
            price -= 7.20
            button34.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(34)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button35Pressed(_ sender: Any) {
        button35.isSelected = !button35.isSelected
        if (button35.isSelected) {
            price += 7.20
            button35.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(35)
        }
        else {
            price -= 7.20
            button35.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(35)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button36Pressed(_ sender: Any) {
        button36.isSelected = !button36.isSelected
        if (button36.isSelected) {
            price += 7.20
            button36.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(36)
        }
        else {
            price -= 7.20
            button36.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(36)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button37Pressed(_ sender: Any) {
        button37.isSelected = !button37.isSelected
        if (button37.isSelected) {
            price += 7.20
            button37.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(37)
        }
        else {
            price -= 7.20
            button37.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(37)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button41Pressed(_ sender: Any) {
        button41.isSelected = !button41.isSelected
        if (button41.isSelected) {
            price += 7.20
            button41.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(41)
        }
        else {
            price -= 7.20
            button41.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(41)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button42Pressed(_ sender: Any) {
        button42.isSelected = !button42.isSelected
        if (button42.isSelected) {
            price += 7.20
            button42.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(42)
        }
        else {
            price -= 7.20
            button42.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(42)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button43Pressed(_ sender: Any) {
        button43.isSelected = !button43.isSelected
        if (button43.isSelected) {
            price += 7.20
            button43.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(43)
        }
        else {
            price -= 7.20
            button43.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(43)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button44Pressed(_ sender: Any) {
        button44.isSelected = !button44.isSelected
        if (button44.isSelected) {
            price += 7.20
            button44.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(44)
        }
        else {
            price -= 7.20
            button44.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(44)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button45Pressed(_ sender: Any) {
        button45.isSelected = !button45.isSelected
        if (button45.isSelected) {
            price += 7.20
            button45.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(45)
        }
        else {
            price -= 7.20
            button45.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(45)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button46Pressed(_ sender: Any) {
        button46.isSelected = !button46.isSelected
        if (button46.isSelected) {
            price += 7.20
            button46.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(46)
        }
        else {
            price -= 7.20
            button46.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(46)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button47Pressed(_ sender: Any) {
        button47.isSelected = !button47.isSelected
        if (button47.isSelected) {
            price += 7.20
            button47.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(47)
        }
        else {
            price -= 7.20
            button47.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(47)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button51Pressed(_ sender: Any) {
        button51.isSelected = !button51.isSelected
        if (button51.isSelected) {
            price += 7.20
            button51.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(51)
        }
        else {
            price -= 7.20
            button51.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(51)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button52Pressed(_ sender: Any) {
        button52.isSelected = !button52.isSelected
        if (button52.isSelected) {
            price += 7.20
            button52.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(52)
        }
        else {
            price -= 7.20
            button52.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(52)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button53Pressed(_ sender: Any) {
        button53.isSelected = !button53.isSelected
        if (button53.isSelected) {
            price += 7.20
            button53.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(53)
        }
        else {
            price -= 7.20
            button53.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(53)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button54Pressed(_ sender: Any) {
        button54.isSelected = !button54.isSelected
        if (button54.isSelected) {
            price += 7.20
            button54.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(54)
        }
        else {
            price -= 7.20
            button54.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(54)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button55Pressed(_ sender: Any) {
        button55.isSelected = !button55.isSelected
        if (button55.isSelected) {
            price += 7.20
            button55.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(55)
        }
        else {
            price -= 7.20
            button55.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(55)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button56Pressed(_ sender: Any) {
        button56.isSelected = !button56.isSelected
        if (button56.isSelected) {
            price += 7.20
            button56.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(56)
        }
        else {
            price -= 7.20
            button56.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(56)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button57Pressed(_ sender: Any) {
        button57.isSelected = !button57.isSelected
        if (button57.isSelected) {
            price += 7.20
            button57.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(57)
        }
        else {
            price -= 7.20
            button57.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(57)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button61Pressed(_ sender: Any) {
        button61.isSelected = !button61.isSelected
        if (button61.isSelected) {
            price += 7.20
            button61.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(61)
        }
        else {
            price -= 7.20
            button61.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(61)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button62Pressed(_ sender: Any) {
        button62.isSelected = !button62.isSelected
        if (button62.isSelected) {
            price += 7.20
            button62.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(62)
        }
        else {
            price -= 7.20
            button62.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(62)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button63Pressed(_ sender: Any) {
        button63.isSelected = !button63.isSelected
        if (button63.isSelected) {
            price += 7.20
            button63.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(63)
        }
        else {
            price -= 7.20
            button63.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(63)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button64Pressed(_ sender: Any) {
        button64.isSelected = !button64.isSelected
        if (button64.isSelected) {
            price += 7.20
            button64.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(64)
        }
        else {
            price -= 7.20
            button64.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(64)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button65Pressed(_ sender: Any) {
        button65.isSelected = !button65.isSelected
        if (button65.isSelected) {
            price += 7.20
            button65.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(65)
        }
        else {
            price -= 7.20
            button65.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(65)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button66Pressed(_ sender: Any) {
        button66.isSelected = !button66.isSelected
        if (button66.isSelected) {
            price += 7.20
            button66.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(66)
        }
        else {
            price -= 7.20
            button66.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(66)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
    

    @IBAction func button67Pressed(_ sender: Any) {
        button67.isSelected = !button67.isSelected
        if (button67.isSelected) {
            price += 7.20
            button67.setImage(imageReserved, for: .normal)
            reserveButton.isEnabled = true
            sedezi.insert(67)
        }
        else {
            price -= 7.20
            button67.setImage(imageFree, for: .normal)
            if (price <= 1) {
                reserveButton.isEnabled = false
            }
            sedezi.remove(67)
        }
        priceLabel.text = String(format: "$%.2f", price)
    }
}




extension ReservationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [.foregroundColor: UIColor.lightGray])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        izbranDatum = pickerData[row]
        reserved(index: indexPicker[row])
    }
}
