//
//  Weather.swift
//  Weather in SwiftUI
//
//  Created by Vahid Sayad on 7/26/21.
//

import Foundation

struct WeatherResponse: Decodable {
    var main: Weather?
    var name: String?
}

struct Weather: Decodable {
    var temp: Double?
    var humidity: Double?
}
