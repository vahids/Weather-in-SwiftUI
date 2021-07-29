//
//  ContentView.swift
//  Weather in SwiftUI
//
//  Created by Vahid Sayad on 7/26/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject private var vm: WeatherViewModel
    
    init() {
        self.vm = WeatherViewModel()
    }
    
    var body: some View {
        VStack {
            
            TextField("Enter City Name", text: $vm.cityName)
                .onReceive(
                    vm.$cityName
                        .debounce(for: .seconds(1), scheduler: DispatchQueue.main), perform: { _ in
                            self.vm.search()
                })
                .font(.custom("Hevalica", size: 35))
                .padding()
            
            Button("Get \(vm.cityName) Weather") {
                self.vm.search()
            }
            
            HStack {
                Text(vm.temperature)
                    .font(.custom("Hevalica", size: 55))
                    .offset(x: 5, y: 20)
                    .foregroundColor(.gray)
                Text(vm.name).padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
