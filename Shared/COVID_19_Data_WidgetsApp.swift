//
//  COVID_19_Data_WidgetsApp.swift
//  Shared
//
//  Created by Alexander Lester on 6/9/21.
//

import SwiftUI

@main
struct COVID_19_Data_WidgetsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                metrics:
                    Metrics(
                        vaccinationsInitiatedRatio: 0.0,
                        vaccinationsCompletedRatio: 0.0
                    ),
                historical: [
                    VaccineData(
                        date: Date(),
                        totalVaccinations: 0,
                        peopleVaccinated: 0,
                        totalVaccinationsPerHundred: 0.0,
                        peopleVaccinatedPerHundred: 0.0,
                        dailyVaccinations: 0,
                        dailyVaccinationsPerMillion: 0,
                        peopleFullyVaccinated: 0,
                        peopleFullyVaccinatedPerHundred: 0.0,
                        dailyVaccinationsRaw: 0
                    )
                ]
            )
        }
    }
}
