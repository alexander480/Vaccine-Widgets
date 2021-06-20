//
//  CovidData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 6/12/21.
//

import Foundation

// MARK: - CovidData
struct CurrentData: Codable {
    let metrics: Metrics
}

// MARK: - Metrics
struct Metrics: Codable {
    let vaccinationsInitiatedRatio, vaccinationsCompletedRatio: Double
    //let date: String?
}

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
//                    self.metrics = covidData.metrics
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


// MARK: - CovidDatum
struct Country: Codable {
    let country, isoCode: String
    let data: [VaccineData]

    enum CodingKeys: String, CodingKey {
        case country
        case isoCode = "iso_code"
        case data
    }
}

// MARK: - Datum
struct VaccineData: Codable {
//    var dateFormatter: DateFormatter
//    var date: Date? {
//
//    }
    // let dateString: String
    let date: Date
    let totalVaccinations, peopleVaccinated: Int?
    let totalVaccinationsPerHundred, peopleVaccinatedPerHundred: Double?
    let dailyVaccinations, dailyVaccinationsPerMillion, peopleFullyVaccinated: Int?
    let peopleFullyVaccinatedPerHundred: Double?
    let dailyVaccinationsRaw: Int?

    enum CodingKeys: String, CodingKey {
        case date
        // case dateString = "date"
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

typealias Vaccinations = [Country]
