//
//  CurrentData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 7/23/21.
//

import Foundation

struct CurrentData: Codable {
    var metrics: CurrentMetric
}

struct CurrentMetric: Codable {
    let initiated: Double
    let completed: Double
	
	let infectionRate: Double?
	let testPositivity: Double?
	let icuCapacity: Double?
	
	init(initiated: Double, completed: Double, infectionRate: Double? = nil, testPositivity: Double? = nil, icuCapacity: Double? = nil) {
		self.initiated = initiated
		self.completed = completed
		
		self.infectionRate = infectionRate
		self.testPositivity = testPositivity
		self.icuCapacity = icuCapacity
	}
    
    enum CodingKeys: String, CodingKey {
        case initiated = "vaccinationsInitiatedRatio"
        case completed = "vaccinationsCompletedRatio"
		
		case infectionRate = "infectionRate"
		case testPositivity = "testPositivityRatio"
		case icuCapacity = "icuCapacityRatio"
    }
}
