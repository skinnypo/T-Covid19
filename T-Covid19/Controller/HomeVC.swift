//
//  HomeVC.swift
//  T-Covid19
//
//  Created by I Putu Krisna on 02/04/20.
//  Copyright © 2020 Blue Skin. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapModeSC: UISegmentedControl!
    
    var annotationViewCollections = [CustomPointAnnotation]()
    var overlayViewCollections = [MKCircle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapModeSC.layer.zPosition = 4
        mapView.delegate = self
        setupMapView()
        fetchAllCountry()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mapModeSCTapped(_ sender: UISegmentedControl) {
        print("aaaaaa")
        switch mapModeSC.selectedSegmentIndex {
        case 0:
            mapView.removeOverlays(overlayViewCollections)
            mapView.addAnnotations(annotationViewCollections)
        case 1:
            mapView.removeAnnotations(annotationViewCollections)
            mapView.addOverlays(overlayViewCollections)
        default:
            break
        }
    }
    
    func setupMapView() {
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
    }
    
    //Not Used Yet
    func fetchSpecificCountry() {
        NetworkingAPI.shared.fetchSpecificCountryDataAPI(countryName: "Indonesia") { (result) in
            DispatchQueue.main.async {
                let annotation = MKPointAnnotation()
                annotation.title = result.country + " - \(result.cases)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: result.countryInfo.lat, longitude: result.countryInfo.long)
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func fetchAllCountry() {
        NetworkingAPI.shared.fetchAllCountryDataAPI() { (result) in
            DispatchQueue.main.async {
                for (index, data) in result.enumerated() {
                    let annotation = self.createAnnotationView(data: data, tag: index)
                    self.annotationViewCollections.append(annotation)
                    self.mapView.addAnnotation(annotation)

                    let overlay = self.createOverlayView(cases: data.cases, lat: data.countryInfo.lat, long: data.countryInfo.long)
                    self.overlayViewCollections.append(overlay)
                }
            }
        }
    }
    
    func createAnnotationView(data: SpecificCountryData, tag: Int) -> CustomPointAnnotation {
        let annotation = CustomPointAnnotation()
        annotation.tag = tag
        annotation.info = """
        Cases : \(data.cases)
        Today Cases : \(data.todayCases)
        Deaths : \(data.deaths)
        Today Deaths : \(data.todayDeaths)
        Recovered : \(data.recovered)
        Active : \(data.active)
        Critical : \(data.critical)
        Updated : \(data.updated)
        """
        annotation.title = data.country
        annotation.subtitle = "Cases: \(data.cases)"
        annotation.coordinate = CLLocationCoordinate2D(latitude: data.countryInfo.lat, longitude: data.countryInfo.long)
        
        return annotation
    }
    
    func createOverlayView(cases: Int, lat: CLLocationDegrees, long: CLLocationDegrees) -> MKCircle {
        let radius = self.defineRadiusOverlay(cases: cases)
        let overlay = MKCircle(center: CLLocationCoordinate2D(latitude: lat, longitude: long), radius: radius)
        
        return overlay
    }
    
    func defineRadiusOverlay(cases: Int) -> CLLocationDistance {
        switch cases {
        case 50000..<250000:
            return 150000
        case 17000..<50000:
            return 125000
        case 3000..<17000:
            return 100000
        case 1600..<3000:
            return 87500
        case 800..<1600:
            return 75000
        case 400..<800:
            return 67500
        case 200..<400:
            return 50000
        case 50..<200:
            return 37500
        case 10..<50:
            return 25000
        case 1..<10:
            return 12500
        default:
            return 12500
        }
    }

}

extension HomeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var circleRenderer = MKCircleRenderer()
        if let overlay = overlay as? MKCircle {
            circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.red
            circleRenderer.strokeColor = .clear
            circleRenderer.alpha = 0.75

        }
        return circleRenderer
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! CustomPointAnnotation
        let countryName = annotation.title
        let countryInfo = annotation.info

        let moreInfo = UIAlertController(title: countryName, message: countryInfo, preferredStyle: .alert)
        moreInfo.addAction(UIAlertAction(title: "OK", style: .default))
        present(moreInfo, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomPointAnnotation {
            print(annotation.tag!)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Covid19"

        if annotation is CustomPointAnnotation {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
    
        }

        return nil
    }
    
}

//Not Used Yet
extension Date {
    func convertToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let newDate: String = dateFormatter.string(from: self)
        
        return newDate
    }
    
}

class CustomPointAnnotation: MKPointAnnotation {
    var tag: Int!
    var info: String!
}
