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
	// let date: Date?
	
	let cases: Int?
	let newCases: Int?
	
	let deaths: Int?
	let newDeaths: Int?
}
