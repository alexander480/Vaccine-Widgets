//
//  HistoricalData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 7/23/21.
//

import Foundation


struct CountryData: Codable {
    let name: String
    let isoCode: String
    var metrics: [HistoricalMetric]

    enum CodingKeys: String, CodingKey {
        case name = "country"
        case isoCode = "iso_code"
        case metrics = "data"
    }
}

struct HistoricalMetric: Codable {
    //let date: Date
    let totalVaccinations, peopleVaccinated: Double?
    let totalVaccinationsPerHundred, peopleVaccinatedPerHundred: Double?
    let dailyVaccinations, dailyVaccinationsPerMillion, peopleFullyVaccinated: Double?
    let peopleFullyVaccinatedPerHundred: Double?
    let dailyVaccinationsRaw: Double?

    enum CodingKeys: String, CodingKey {
        //case date
        case totalVaccinations = "total_vaccinations"
        case peopleVaccinated = "people_vaccinated"
        case totalVaccinationsPerHundred = "total_vaccinations_per_hundred"
        case peopleVaccinatedPerHundred = "people_vaccinated_per_hundred"
        case dailyVaccinations = "daily_vaccinations"
        case dailyVaccinationsPerMillion = "daily_vaccinations_per_million"
        case peopleFullyVaccinated = "people_fully_vaccinated"
        case peopleFullyVaccinatedPerHundred = "people_fully_vaccinated_per_hundred"
        case dailyVaccinationsRaw = "daily_vaccinations_raw"
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

