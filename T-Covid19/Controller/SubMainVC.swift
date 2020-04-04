//
//  SubMainVC.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 03/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import UIKit

class SubMainVC: UIViewController {
 
    @IBOutlet weak var flagCountryIV: UIImageView!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var casesLbl: UILabel!
    @IBOutlet weak var tcasesLbl: UILabel!
    @IBOutlet weak var deathsLbl: UILabel!
    @IBOutlet weak var tdeathsLbl: UILabel!
    @IBOutlet weak var recoveredLbl: UILabel!
    @IBOutlet weak var activeLbl: UILabel!
    @IBOutlet weak var criticalLbl: UILabel!
    @IBOutlet weak var updatedLbl: UILabel!
    
    var specificCountry = [SpecificCountryData]()
    var flagCountry = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationItem.backBarButtonItem?.title = specificCountry[0].country
        flagCountryIV.image = flagCountry
        countryNameLbl.text = specificCountry[0].country
        casesLbl.text = "\(specificCountry[0].cases)"
        tcasesLbl.text = "\(specificCountry[0].todayCases)"
        deathsLbl.text = "\(specificCountry[0].deaths)"
        tdeathsLbl.text = "\(specificCountry[0].todayDeaths)"
        recoveredLbl.text = "\(specificCountry[0].recovered)"
        activeLbl.text = "\(specificCountry[0].active)"
        criticalLbl.text = "\(specificCountry[0].critical)"
        updatedLbl.text = "\(specificCountry[0].updated)"
    }

}
