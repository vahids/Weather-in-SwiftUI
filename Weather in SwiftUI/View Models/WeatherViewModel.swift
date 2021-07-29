//
//  WeatherViewModel.swift
//  Weather in SwiftUI
//
//  Created by Vahid Sayad on 7/27/21.
//

import Foundation

class WeatherViewModel: ObservableObject {
    private var apiService: WeatherService
    @Published var weatherResponse = WeatherResponse()
    @Published var error = ""
    @Published var cityName = ""
    
    init() {
        apiService = WeatherService()
    }
    
    func search() {
        guard let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        self.search(by: city)
    }
    
    var temperature: String {
        guard let temp = weatherResponse.main?.temp else { return ""}
        return String(format: "%.0f", temp)
    }
    
    var name: String {
        return weatherResponse.name ?? ""
    }
    
    private func search(by city: String) {
        apiService.urlSession.finishTasksAndInvalidate()
        
        apiService.getWeather(city: city) { result in
            switch result {
            case .failure(let error):
                self.error = error.localizedDescription
                self.weatherResponse = WeatherResponse()
                print("Error")
            case .success(let weather):
                self.weatherResponse = weather
                self.error = ""
                print("Success")
            }
        }
    }
    
    
}
