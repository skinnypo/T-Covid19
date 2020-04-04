//
//  MainTVC.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 03/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import UIKit

class MainTVC: UITableViewCell {

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCases: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
