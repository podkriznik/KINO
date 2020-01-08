//
//  CellTableViewCell.swift
//  KinoiPad
//
//  Created by Nace Selišnik on 04/05/2019.
//  Copyright © 2019 Nace Selisnik. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    
    //@IBOutlet weak var img: UIImageView!
    //@IBOutlet weak var lbl_naslov: UILabel!
    //@IBOutlet weak var lbl_opis: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_naslov: UILabel!
    @IBOutlet weak var lbl_opis: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let colorView = UIView()
        colorView.backgroundColor =  UIColor(red: (25/255.0), green: (225/255.0), blue: (225/255.0), alpha: 0)
        
        
        
        // use UITableViewCell.appearance() to configure
        // the default appearance of all UITableViewCells in your app
        UITableViewCell.appearance().selectedBackgroundView = colorView
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
