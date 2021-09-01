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
	@Published var historical: [HistoricalMetric] = [HistoricalMetric(date: Date(), totalVaccinations: 0.0, peopleVaccinated: 0.0, totalVaccinationsPerHundred: 0.0, peopleVaccinatedPerHundred: 0.0, dailyVaccinations: 0.0, dailyVaccinationsPerMillion: 0.0, peopleFullyVaccinated: 0.0, peopleFullyVaccinatedPerHundred: 0.0, dailyVaccinationsRaw: 0.0)]
	@Published var actuals: [ActualData] = [ActualData(date: Date(), newCases: 0, newDeaths: 0, cases: 0, deaths: 0, vaccinesAdministered: 0)]

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
					// Setup Decoder For Date Format
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
					
					// Decode Actual Data
                    let allCountries = try decoder.decode([CountryData].self, from: data)
					
					// Locate Data For Specific Country
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
					// Setup Decoder For Date Format
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
					
					// Decode Data
					let historicalData = try decoder.decode(ActNowHistoricalData.self, from: data)
					let actuals = historicalData.actualsTimeseries
					
					DispatchQueue.main.async { self.actuals = actuals }
					print("[SUCCESS] Successfully Validated ActNowHistoricalData Actuals. [DATA] \(actuals.count) Entries.")
					
				} catch let decodeError { print("[ERROR] Failed To Decode ActNowHistoricalData. [MESSAGE] \(decodeError.localizedDescription).") }
			} else if let error = error { print("[ERROR] Failed To Validate ActNowHistoricalData. [MESSAGE] \(error.localizedDescription).") }
		}.resume()
	}
	
	// MARK: Persisting Data
	// ----
	
	// MARk: Example From Apple
	// ----
	
//
//	private static var documentsFolder: URL {
//		do {
//			return try FileManager.default.url(for: .documentDirectory,
//											   in: .userDomainMask,
//											   appropriateFor: nil,
//											   create: false)
//		} catch {
//			fatalError("Can't find documents directory.")
//		}
//	}
//	private static var fileURL: URL {
//		return documentsFolder.appendingPathComponent("scrums.data")
//	}
//
//	func load() {
//		DispatchQueue.global(qos: .background).async { [weak self] in
//			guard let data = try? Data(contentsOf: Self.fileURL) else {
//				#if DEBUG
//				DispatchQueue.main.async {
//					self?.scrums = DailyScrum.data
//				}
//				#endif
//				return
//			}
//			guard let dailyScrums = try? JSONDecoder().decode([DailyScrum].self, from: data) else {
//				fatalError("Can't decode saved scrum data.")
//			}
//			DispatchQueue.main.async {
//				self?.scrums = dailyScrums
//			}
//		}
//	}
//	func save() {
//		DispatchQueue.global(qos: .background).async { [weak self] in
//			guard let scrums = self?.scrums else { fatalError("Self out of scope") }
//			guard let data = try? JSONEncoder().encode(scrums) else { fatalError("Error encoding data") }
//			do {
//				let outfile = Self.fileURL
//				try data.write(to: outfile)
//			} catch {
//				fatalError("Can't write to file")
//			}
//		}
//	}
}
