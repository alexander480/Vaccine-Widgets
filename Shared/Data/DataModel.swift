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
	@Published var actuals: [ActualData] = [ActualData()]
	@Published var vaccinationTrends: [VaccinationTrendEntry] = [VaccinationTrendEntry(date: Date())]

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
	
	func fetchVaccinationTrends(/*forState: String? = "US"*/) {
		// let url = URL(string: "https://data.cdc.gov/resource/rh2h-3yt2.json?location=\(forState)")!
		let url = URL(string: "https://data.cdc.gov/resource/rh2h-3yt2.json?location=US")!
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let data = data {
				do {
					// Setup Decoder For Date Format
					let decoder = JSONDecoder()
						decoder.dateDecodingStrategy = .formatted(DateFormatter.cdcDateFormat)
					
					// Decode Actual Data
					let vaccinationTrends = try decoder.decode([VaccinationTrendEntry].self, from: data)
					
					print("[SUCCESS] Successfully Validated Vaccination Trends [INFO] \(vaccinationTrends.count) Entries.")
					DispatchQueue.main.async { self.vaccinationTrends = vaccinationTrends }

				} catch let decodeError { print("[ERROR] Failed To Decode Vaccination Trends Data. [MESSAGE] \(decodeError.localizedDescription)") }
			} else if let error = error { print("[ERROR] Failed To Validate Vaccination Trends Data. [MESSAGE] \(error.localizedDescription)") }
		}.resume()
	}
	
	// MARK: Persisting Data
	// ----
	// Example From Apple
	
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
