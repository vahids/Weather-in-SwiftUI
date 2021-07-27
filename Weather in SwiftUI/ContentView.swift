//
//  ContentView.swift
//  Weather in SwiftUI
//
//  Created by Vahid Sayad on 7/26/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temp = ""
    @State private var humidity = ""
    @State private var color = Color.black
    
    var body: some View {
        VStack {
            HStack {
                Text("Tempurature: ")
                Text(temp)
                    .foregroundColor(color)
            }.padding()
            
            HStack {
                Text("Humidity: ")
                Text(humidity)
                    .foregroundColor(color)
            }.padding()
            
            Button("Start") {
                self.getWeather(city: "Shiraz")
            }
        }
    }
    
    func getWeather(city: String) {
        WeatherService().getWeather(city: "Shiraz") { res in
            switch res {
            case .failure(let error):
                self.temp = error.localizedDescription
                self.humidity = error.localizedDescription
                self.color = .red
            case .success(let weather):
                self.temp = "\(weather.temp ?? 0)"
                self.humidity = "\(weather.humidity ?? 0)"
                self.color = .green
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
