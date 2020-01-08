//
//  CellMain.swift
//  KINO - iOS
//
//  Created by Aljaz Podkriznik on 04/05/2019.
//  Copyright © 2019 Aljaz Podkriznik. All rights reserved.
//

import UIKit

class CellMain: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
