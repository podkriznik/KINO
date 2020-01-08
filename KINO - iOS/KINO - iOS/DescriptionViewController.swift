//
//  DescriptionViewController.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 29/04/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var screenplayLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Do any additional setup after loading the view.
        let ure = filmCollection[index].trajanje / 60
        let minute = filmCollection[index].trajanje % 60
        let trajanje:String = String(ure) + "h " + String(minute) + "min"
        
        titleLabel.text = (filmCollection[index].naslov).uppercased()
        descriptionLabel.text = filmCollection[index].opis
        genreLabel.text = filmCollection[index].zanr
        durationLabel.text = String(trajanje)
        ratingLabel.text = String(filmCollection[index].ocena)
        directorLabel.text = filmCollection[index].direktor
        screenplayLabel.text = filmCollection[index].scenarij
        releaseDateLabel.text = filmCollection[index].datumIzhoda
        castLabel.text = filmCollection[index].zasedba
        
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.minimumScaleFactor = 0.5;
        self.titleLabel.adjustsFontSizeToFitWidth = true;
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func reservationPressed(_ sender: Any) {
        let reservation = self.storyboard?.instantiateViewController(withIdentifier: "Reservation") as! ReservationViewController
        reservation.index = index
        self.navigationController?.pushViewController(reservation, animated: true)
    }
    
}
