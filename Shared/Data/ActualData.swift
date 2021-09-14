//
//  ActNowHistoricalData.swift
//  COVID-19 Vaccination Widgets
//
//  Created by Alexander Lester on 8/30/21.
//

import Foundation

struct ActNowHistoricalData: Codable {
	let actualsTimeseries: [ActualData]
}

struct ActualData: Codable {
	let date: Date
	
	let newCases: Int?
	let newDeaths: Int?
	
	let cases: Int?
	let deaths: Int?
	
	// convert [vaccinesAdministered] from running total [12, 14, 16] -> daily change [2, 2]
	// to use for Daily Vaccinations
	let vaccinesAdministered: Int?
	
	init(date: Date? = Date(), newCases: Int? = 0, newDeaths: Int? = 0, cases: Int? = 0, deaths: Int? = 0, vaccinesAdministered: Int? = 0) {
		self.date = date ?? Date()
		self.newCases = newCases
		self.newDeaths = newDeaths
		self.cases = cases
		self.deaths = deaths
		self.vaccinesAdministered = vaccinesAdministered
	}
}

extension Array where Element == ActualData {
	var newCasesAverage: [Double] {
		let dailyCases: [Int] = self.compactMap({ return $0.newCases })
		var dailyCasesTimeline: [Double] = dailyCases.map { return Double($0) }
		
		if dailyCases.count > 7 {
			let dailyCasesAverage = dailyCases.movingAverage(period: 7)
			let dailyCasesAveragedTimeline = dailyCasesAverage.sorted { $0.key < $1.key }.map { Double($0.value) }
			dailyCasesTimeline = dailyCasesAveragedTimeline
		}
		
		return dailyCasesTimeline
	}
	
	func getPeriod(_ period: Calendar.Component) -> [ActualData] {
		return self.filter { $0.date.isInCurrent(period) }
	}
}
