//
//  VaccineData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 7/24/21.
//

import Foundation

class DataModel: ObservableObject {
    @Published var current: CurrentMetric = CurrentMetric(initiated: 0.02, completed: 0.01)
    @Published var historical: [HistoricalMetric] = [HistoricalMetric]()
    
    init(isoCode: String = "USA") {
        self.fetchCurrent()
        self.fetchHistorical(isoCode: isoCode)
    }
    
    func fetchCurrent() {
        let url = URL(string: "https://api.covidactnow.org/v2/country/US.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let currentData = try JSONDecoder().decode(CurrentData.self, from: data)
                    print("[SUCCESS] Successfully Validated Current Data. [DATA] \(currentData.metrics)")
                    DispatchQueue.main.async { self.current = currentData.metrics }
                } catch let decodeError { print("[ERROR] Failed To Decode Current Data. [MESSAGE] \(decodeError.localizedDescription).") }
            } else if let error = error { print("[ERROR] Failed To Validate Current Data. [MESSAGE] \(error.localizedDescription).") }
        }.resume()
    }
    
    func fetchHistorical(isoCode: String) {
        let url = URL(string: "https://covid.ourworldindata.org/data/vaccinations/vaccinations.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let allCountries = try JSONDecoder().decode([CountryData].self, from: data)
                    if let specifiedCountry = allCountries.first(where: { $0.isoCode == isoCode }) {
                        print("[SUCCESS] Successfully Validated Historical Metrics For Specified Country. [DATA] \(specifiedCountry.metrics.count) Entries.")
                        DispatchQueue.main.async { self.historical = specifiedCountry.metrics }
                    }
                    else { print("[ERROR] Failed To Validate Historical Data For Specified Country.") }
                } catch let decodeError { print("[ERROR] Failed To Decode Historical Data. [MESSAGE] \(decodeError.localizedDescription).") }
            } else if let error = error { print("[ERROR] Failed To Validate Historical Data. [MESSAGE] \(error.localizedDescription).") }
        }.resume()
    }
}
