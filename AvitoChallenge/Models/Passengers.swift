//
//  Passengers.swift
//  AvitoChallenge
//
//  Created by Fly on 15/09/2018.
//

import Foundation

struct Passengers: Decodable {
    var message: String?
    var number: Int?
    var people: [Peaple]?
}
