//
//  VaccinationTrends.swift
//  VaccinationTrends
//
//  Created by Alexander Lester on 9/12/21.
//

import Foundation

// typealias VaccinationTrends = [VaccinationTrendEntry]

struct VaccinationTrendEntry: Codable {
	let date: Date
	let location: String
	
	private let dailyVaccinations_String: String
	private let cumulativeVaccinations_String: String
	private let rollingAverage_String: String // 7 Day Rolling Average
	
	enum CodingKeys: String, CodingKey {
		case date = "date"
		case location = "location"
		case dailyVaccinations_String = "administered_daily"
		case cumulativeVaccinations_String = "administered_cumulative"
		case rollingAverage_String = "administered_7_day_rolling"
	}
	
	init(date: Date, location: String? = "US", dailyVaccinations: Double? = 0, cumulativeVaccinations: Double? = 0, rollingAverage: Double? = 0) {
		self.date = date
		self.location = location ?? "US"
		self.dailyVaccinations_String = String(describing: dailyVaccinations)
		self.cumulativeVaccinations_String = String(describing: cumulativeVaccinations)
		self.rollingAverage_String = String(describing: rollingAverage)
	}
}

extension VaccinationTrendEntry {
	var dailyVaccinations: Double { return Double(self.dailyVaccinations_String) ?? 0.0 }
	var cumulativeVaccinations: Double { return Double(self.cumulativeVaccinations_String) ?? 0.0 }
	var rollingAverage: Double { return Double(self.rollingAverage_String) ?? 0.0 }
}

extension Array where Element == VaccinationTrendEntry {
	var dailyVaccinationsAverage: [Double] {
		let dailyVaccinations: [Int] = self.map { Int($0.dailyVaccinations) ?? 0 }
		var dailyVaccinationsTimeline: [Double] = self.map { $0.dailyVaccinations }
		
		if dailyVaccinationsTimeline.count > 7 {
			let dailyVaccinationsAverage = dailyVaccinations.movingAverage(period: 7)
			dailyVaccinationsTimeline = dailyVaccinationsAverage.sorted { $0.key < $1.key }.map { Double($0.value) }
		}
		
		return dailyVaccinationsTimeline
	}
}
