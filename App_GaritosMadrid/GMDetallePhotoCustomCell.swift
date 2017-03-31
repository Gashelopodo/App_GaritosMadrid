//
//  GMDetallePhotoCustomCell.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class GMDetallePhotoCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var myTitulo: UILabel!
    @IBOutlet weak var myThumb: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
