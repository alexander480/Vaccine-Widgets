//
//  CaseTimeline.swift
//  CaseTimeline
//
//  Created by Alexander Lester on 9/12/21.
//

import Foundation

typealias StateCasesTimeline = [StateEntry]

struct StateEntry: Codable {
	let date: Date
	let state: UnitedStates
	
	var totalCases: Double { return Double(self.totalCasesString) ?? 0.0 }
	private let totalCasesString: String
	
	var totalDeaths: Double { return Double(self.totalDeathsString) ?? 0.0 }
	private let totalDeathsString: String
	
	var newCases: Double { return Double(self.newCasesString) ?? 0.0 }
	private let newCasesString: String
	
	var newDeaths: Double { return Double(self.newDeathsString) ?? 0.0 }
	private let newDeathsString: String
	
	enum CodingKeys: String, CodingKey {
		case date = "submission_date"
		case state = "state"
		case totalCasesString = "tot_cases"
		case totalDeathsString = "tot_death"
		case newCasesString = "new_case"
		case newDeathsString = "new_death"
	}
}

struct CountryEntry {
	let date: Date
	let totalCases: Double
	let totalDeaths: Double
	let newCases: Double
	let newDeaths: Double
	
	init(date: Date, totalCases: Double, totalDeaths: Double, newCases: Double, newDeaths: Double) {
		self.date = date
		self.totalCases = totalCases
		self.newCases = newCases
		self.totalDeaths = totalDeaths
		self.newDeaths = newDeaths
	}
}

//extension StateCasesTimeline {
//	func countryTimeline() -> [CountryEntry] {
//		var countryTimeline = [CountryEntry]()
//
//		var allDates = self.map { return $0.date }.removeDuplicates()
//		for date in allDates {
//			let stateEntriesForDate = self.filter { return $0.date.daysSince(date).isZero }
//			let
//		}
//	}
//}
