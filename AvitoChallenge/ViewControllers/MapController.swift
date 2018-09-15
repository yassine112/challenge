//
//  ViewController.swift
//  AvitoChallenge
//
//  Created by Fly on 14/09/2018.
//

import UIKit
import MapKit

class MapController: UIViewController {

    let issActualLocationUrl = "http://api.open-notify.org/iss-now.json"
    let span = MKCoordinateSpan(latitudeDelta: 75, longitudeDelta: 75)
    let annotation = MKPointAnnotation()
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    var issActualLocation: Iss?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ISS Actual Location"
        view.addSubview(mapView)

        let constraints = [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)

        mapView.addAnnotation(annotation)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(showActualLocation), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func showActualLocation() {
        getIssLocation { (lat, long) in
            print(lat, long)
            self.setIssActualPosition(lat: lat, long: long)
        }
    }

    func getIssLocation(completion: @escaping (_ lat: Double, _ long: Double) -> Void) {
        guard let url = URL(string: issActualLocationUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {

                self.issActualLocation = try JSONDecoder().decode(Iss.self, from: data)
                if let stringLat = self.issActualLocation?.iss_position?.latitude, let stringLong = self.issActualLocation?.iss_position?.longitude, let lat = Double(stringLat), let long = Double(stringLong) {
                    completion(lat, long)
                }

            } catch let jsonErr {
                print("error JSONSerialization", jsonErr)
            }
        }.resume()
    }

    func setIssActualPosition(lat: Double, long: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)
        annotation.coordinate = location

    }

}

