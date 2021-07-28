//
//  CurrentData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 7/23/21.
//

import Foundation

struct CurrentData: Codable {
    var metrics: CurrentMetric
}

struct CurrentMetric: Codable {
    let initiated: Double
    let completed: Double
    
    enum CodingKeys: String, CodingKey {
        case initiated = "vaccinationsInitiatedRatio"
        case completed = "vaccinationsCompletedRatio"
    }
}

// -- Previously Used For CurrentData & HistoricalData

// MARK: - loadData - Put Inside ContentView

//func loadData() {
//    guard let url = URL(string: "https://api.covidactnow.org/v2/country/US.timeseries.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb") else {
//        print("[ERROR] Failed To Validate URL From String.")
//        return
//    }
//
//    let request = URLRequest(url: url)
//
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//            if let covidData = try? JSONDecoder().decode(CovidData.self, from: data) {
//                DispatchQueue.main.async {
//                    self.current = covidData.metrics
//                    self.timeseriesMetrics = covidData.metricsTimeseries
//                    print(covidData)
//                }
//
//                return
//            }
//        }
//
//        print("[ERROR] Failed To Fetch Data. [MESSAGE] \(error?.localizedDescription ?? "Unknown Error.")")
//    }.resume()
//}

