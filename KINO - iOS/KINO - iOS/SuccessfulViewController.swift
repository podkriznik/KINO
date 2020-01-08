//
//  SuccessfulViewController.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 29/04/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import UIKit

class SuccessfulViewController: UIViewController {

    @IBOutlet weak var codeLabel: UILabel!
    var idRezervacija:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeLabel.text = String(idRezervacija)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
