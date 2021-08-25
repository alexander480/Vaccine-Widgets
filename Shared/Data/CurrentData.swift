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
    
    enum CodingKeys: String, CodingKey {
        case initiated = "vaccinationsInitiatedRatio"
        case completed = "vaccinationsCompletedRatio"
    }
}
