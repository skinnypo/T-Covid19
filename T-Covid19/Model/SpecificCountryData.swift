//
//  CountryData.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 02/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SpecificCountryData: Codable {
    let country: String
    let countryInfo: CountryInfo
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let active: Int
    let critical: Int
//    let casesPerOneMillion: Float
//    let deathsPerOneMillion: Float
    let updated: Int
    
    struct CountryInfo: Codable {
//        let _id: Int
//        let iso2: String
//        let iso3: String
        let lat: CLLocationDegrees
        let long: CLLocationDegrees
        let flag: String
    }
    
//    enum CodingKeys: String, CodingKey {
//        case country
//        case cases
//    }
    
}
