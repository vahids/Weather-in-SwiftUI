//
//  WeatherService.swift
//  Weather in SwiftUI
//
//  Created by Vahid Sayad on 7/26/21.
//

import Foundation

class WeatherService {
    
    let urlSession = URLSession.shared
    
    func getWeather(city: String, completion: @escaping (Result<WeatherResponse, Error>)->() ) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(APIKEY)&units=metric") else {
            DispatchQueue.main.async {
                completion(.failure(URLError(URLError.Code.badURL)))
            }
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error ?? URLError(URLError.Code.cannotDecodeRawData)))
                }
                return
            }

            let weather = Result {
                try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            
            DispatchQueue.main.async {
                completion(weather)
            }
        }.resume()
    }
}
