//
//  NetworkingAPI.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 02/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import Foundation
import UIKit

final class NetworkingAPI {
    static var shared = NetworkingAPI()
    
    private init() {}
    
    func fetchAllDataAPI(completion: @escaping (AllData) -> Void) {
        let url = "https://corona.lmao.ninja/all"
        let urlAPI = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: urlAPI) { (data, response, error) in
            if let error = error {
                print("Error with fetching API: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let data = data,
                let allDataCovid19 = try? JSONDecoder().decode(AllData.self, from: data) {
                completion(allDataCovid19)
            } else {
                print("Error, decode failed")
            }
        }
        task.resume()
    }
    
    func fetchSpecificCountryDataAPI(countryName: String, completion: @escaping (SpecificCountryData) -> Void) {
        let url = "https://corona.lmao.ninja/countries/" + countryName
        print(url)
        let urlAPI = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: urlAPI) { (data, response, error) in
            if let error = error {
                print("Error with fetching API: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let data = data,
                let allDataCovid19 = try? JSONDecoder().decode(SpecificCountryData.self, from: data) {
                completion(allDataCovid19)
            } else {
                print("Error, decode failed")
            }
        }
        task.resume()
    }
    
    func fetchAllCountryDataAPI(completion: @escaping ([SpecificCountryData]) -> Void) {
        let url = "https://corona.lmao.ninja/countries"
        print(url)
        let urlAPI = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: urlAPI) { (data, response, error) in
            if let error = error {
                print("Error with fetching API: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
                let allDataCovid19 = try? JSONDecoder().decode([SpecificCountryData].self, from: data) {
                let sortedData = allDataCovid19.sorted(by: { $0.country < $1.country })
                completion(sortedData)
            } else {
                print("Error, decode failed")
            }
        }
        task.resume()
    }
    
    func fetchFlagCountryImage(url: String, completion: @escaping (UIImage) -> Void) {
        let urlFlag = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: urlFlag) { (data, response, error) in
            if let error = error {
                print("Error with fetching API: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Error, decode failed")
            }
        }
        task.resume()
    }
    
}
