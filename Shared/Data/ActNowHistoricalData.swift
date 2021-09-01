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
}
