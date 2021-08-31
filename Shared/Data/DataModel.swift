//
//  VaccineData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 7/24/21.
//

import Foundation

class DataModel: ObservableObject {
	var isoCode: String = "USA"
    @Published var current: CurrentMetric = CurrentMetric(initiated: 0.00, completed: 0.00)
	@Published var historical: [HistoricalMetric] = [HistoricalMetric(totalVaccinations: 0.0, peopleVaccinated: 0.0, totalVaccinationsPerHundred: 0.0, peopleVaccinatedPerHundred: 0.0, dailyVaccinations: 0.0, dailyVaccinationsPerMillion: 0.0, peopleFullyVaccinated: 0.0, peopleFullyVaccinatedPerHundred: 0.0, dailyVaccinationsRaw: 0.0)]
	@Published var actuals: [ActualData] = [ActualData(cases: 0, newCases: 0, deaths: 0, newDeaths: 0, vaccinesAdministered: 0)]

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
    
    func fetchHistorical() {
        let url = URL(string: "https://covid.ourworldindata.org/data/vaccinations/vaccinations.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let allCountries = try JSONDecoder().decode([CountryData].self, from: data)
					if let specifiedCountry = allCountries.first(where: { $0.isoCode == self.isoCode }) {
                        print("[SUCCESS] Successfully Validated Historical Metrics For Specified Country. [DATA] \(specifiedCountry.metrics.count) Entries.")
                        DispatchQueue.main.async { self.historical = specifiedCountry.metrics }
                    }
                    else { print("[ERROR] Failed To Validate Historical Data For Specified Country.") }
                } catch let decodeError { print("[ERROR] Failed To Decode Historical Data. [MESSAGE] \(decodeError.localizedDescription).") }
            } else if let error = error { print("[ERROR] Failed To Validate Historical Data. [MESSAGE] \(error.localizedDescription).") }
        }.resume()
    }
	
	func fetchActuals() {
		let url = URL(string: "https://api.covidactnow.org/v2/country/US.timeseries.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb")!
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let data = data {
				do {
					let historicalData = try JSONDecoder().decode(ActNowHistoricalData.self, from: data)
					let actuals = historicalData.actualsTimeseries
					DispatchQueue.main.async { self.actuals = actuals }
					print("[SUCCESS] Successfully Validated ActNowHistoricalData Actuals. [DATA] \(actuals.count) Entries.")
				} catch let decodeError { print("[ERROR] Failed To Decode ActNowHistoricalData. [MESSAGE] \(decodeError.localizedDescription).") }
			} else if let error = error { print("[ERROR] Failed To Validate ActNowHistoricalData. [MESSAGE] \(error.localizedDescription).") }
		}.resume()
	}
}
