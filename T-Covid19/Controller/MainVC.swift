//
//  MainVC.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 03/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var countryTV: UITableView!
    var countryData = [SpecificCountryData]()
    var countryFlag = [UIImage]()
    var clickedTV = Int()
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Maps", style: .plain, target: self, action: #selector(mapsButtonTapped))
        fetchAllCountry()
    }
    
    @objc func mapsButtonTapped() {
        performSegue(withIdentifier: "toMaps", sender: self)
    }
    
    func fetchAllCountry() {
        NetworkingAPI.shared.fetchAllCountryDataAPI() { (result) in
            self.countryData.removeAll()
            self.countryFlag.removeAll()
            for data in result {
                NetworkingAPI.shared.fetchFlagCountryImage(url: data.countryInfo.flag) { (image) in
                    self.countryFlag.append(image)
                    self.countryData.append(data)
                    DispatchQueue.main.async {
                        self.countryTV.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        navigationController?.navigationBar.prefersLargeTitles = false
        if segue.identifier == "toSubMain" {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: countryData[clickedTV].country, style: .plain, target: nil, action: nil)
            let vc = segue.destination as! SubMainVC
            vc.specificCountry = [countryData[clickedTV]]
            vc.flagCountry = countryFlag[clickedTV]
        }
    }

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTV.dequeueReusableCell(withIdentifier: "mainTVC", for: indexPath) as! MainTVC
        cell.countryImage.image = countryFlag[indexPath.row]
        cell.countryName.text = countryData[indexPath.row].country
        cell.countryCases.text = "Cases: \(countryData[indexPath.row].cases)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickedTV = indexPath.row
        performSegue(withIdentifier: "toSubMain", sender: self)
    }
    
}
