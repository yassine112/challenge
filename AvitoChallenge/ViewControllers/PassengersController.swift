//
//  PassengersController.swift
//  AvitoChallenge
//
//  Created by Fly on 15/09/2018.
//

import UIKit

class PassengersController: UITableViewController {

    let passengerApiUrl = "http://api.open-notify.org/astros.json"

    let cellId = "cellId"
    var passengers: Passengers?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Passengers"

        getPassenger()
    }

    func getPassenger() {
                guard let url = URL(string: passengerApiUrl) else {
                    return
                }

                URLSession.shared.dataTask(with: url) { (data, resp, err) in
                    guard let data = data else { return }


                    do {
                        self.passengers = try JSONDecoder().decode(Passengers.self, from: data)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let err {
                        print(err)
                    }
                }.resume()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passengers?.number ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        if let peaple = passengers?.peaple {

            cell.textLabel?.text = peaple[indexPath.row].name

        }

        return cell
    }
}
