//
//  MainController.swift
//  AvitoChallenge
//
//  Created by Fly on 15/09/2018.
//

import UIKit


class MainController: UITabBarController {


    override func viewDidLoad() {
        super .viewDidLoad()

        let mapController = UINavigationController(rootViewController: MapController())
        mapController.title = "Live Location"
        mapController.tabBarItem.image = UIImage(named: "location")

        let passengersController = UINavigationController(rootViewController: PassengersController())
        passengersController.title = "Passengers"
        passengersController.tabBarItem.image = UIImage(named: "passenger")

        let passTimeController = UINavigationController(rootViewController: PassTimeController())
        passTimeController.title = "Pas Time"
        passTimeController.tabBarItem.image = UIImage(named: "passenger")
        
        viewControllers = [mapController, passengersController, passTimeController]
    }


}
