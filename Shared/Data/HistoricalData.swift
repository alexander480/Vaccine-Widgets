//
//  HistoricalData.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 7/23/21.
//

import Foundation

struct CountryData: Codable {
    let name: String
    let isoCode: String
    var metrics: [HistoricalMetric]

    enum CodingKeys: String, CodingKey {
        case name = "country"
        case isoCode = "iso_code"
        case metrics = "data"
    }
}

struct HistoricalMetric: Codable {
    let date: Date
    let totalVaccinations, peopleVaccinated: Double?
    let totalVaccinationsPerHundred, peopleVaccinatedPerHundred: Double?
    let dailyVaccinations, dailyVaccinationsPerMillion, peopleFullyVaccinated: Double?
    let peopleFullyVaccinatedPerHundred: Double?
    let dailyVaccinationsRaw: Double?

    enum CodingKeys: String, CodingKey {
        case date
        case totalVaccinations = "total_vaccinations"
        case peopleVaccinated = "people_vaccinated"
        case totalVaccinationsPerHundred = "total_vaccinations_per_hundred"
        case peopleVaccinatedPerHundred = "people_vaccinated_per_hundred"
        case dailyVaccinations = "daily_vaccinations"
        case dailyVaccinationsPerMillion = "daily_vaccinations_per_million"
        case peopleFullyVaccinated = "people_fully_vaccinated"
        case peopleFullyVaccinatedPerHundred = "people_fully_vaccinated_per_hundred"
        case dailyVaccinationsRaw = "daily_vaccinations_raw"
    }
	
	init(date: Date? = Date(), totalVaccinations: Double? = 0.0, peopleVaccinated: Double? = 0.0, totalVaccinationsPerHundred: Double? = 0.0, peopleVaccinatedPerHundred: Double? = 0.0, dailyVaccinations: Double? = 0.0, dailyVaccinationsPerMillion: Double? = 0.0, peopleFullyVaccinated: Double? = 0.0, peopleFullyVaccinatedPerHundred: Double? = 0.0, dailyVaccinationsRaw: Double? = 0.0) {
		self.date = date ?? Date()
		self.totalVaccinations = totalVaccinations
		self.peopleVaccinated = peopleVaccinated
		self.totalVaccinationsPerHundred = totalVaccinationsPerHundred
		self.peopleVaccinatedPerHundred = peopleVaccinatedPerHundred
		self.dailyVaccinations = dailyVaccinations
		self.dailyVaccinationsPerMillion = dailyVaccinationsPerMillion
		self.peopleFullyVaccinated = peopleFullyVaccinated
		self.peopleFullyVaccinatedPerHundred = peopleFullyVaccinatedPerHundred
		self.dailyVaccinationsRaw = dailyVaccinationsRaw
	}
}
