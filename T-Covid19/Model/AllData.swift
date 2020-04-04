//
//  AllData.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 02/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import Foundation
import UIKit

class AllData: Codable {
    let cases: Int
    let deaths: Int
    let recovered: Int
    let updated: Date
    let active: Int
    let affectedCountries: Int
    
    init() {
        self.cases = 0
        self.deaths = 0
        self.recovered = 0
        self.updated = Date()
        self.active = 0
        self.affectedCountries = 0
    }
}
