//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Lester on 6/9/21.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State var metrics: Metrics
    @State var historical: [VaccineData]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            let initiatedPercentage = metrics.vaccinationsInitiatedRatio.toPercentage()
            let completedPercentage = metrics.vaccinationsCompletedRatio.toPercentage()
            let unvaccinatedPercentage = 100 - initiatedPercentage
            
            let partiallyVaccinated: [Double] = historical.filter{ $0.peopleVaccinatedPerHundred != nil }.map{ $0.peopleVaccinatedPerHundred!.rounded() }
            let fullyVaccinated: [Double] = historical.filter{ $0.peopleFullyVaccinatedPerHundred != nil }.map{ $0.peopleFullyVaccinatedPerHundred!.rounded() }
            
            
//            let completedRatioSeries: [Double] = timeseriesMetrics.map { metric in
//                return (metric.vaccinationsCompletedRatio * 100).rounded()
//            }
//
//            let initiatedRatioSeries: [Double] = timeseriesMetrics.map { metric in
//                return (metric.vaccinationsInitiatedRatio * 100).rounded()
//            }
//
//            let unvaccinatedRatioSeries: [Double] = timeseriesMetrics.map { metric in
//                let initiated = (metric.vaccinationsInitiatedRatio * 100).rounded()
//                return 100 - initiated
//            }
            
//            MultiLineChartView(data: [(completedRatioSeries, GradientColors.green), (initiatedRatioSeries, GradientColors.orange), (unvaccinatedRatioSeries, GradientColors.orngPink)], title: "Vaccine")
            
            //MultiLineChartView(data: [(populationVaccinatedOverTime, GradientColors.green)], title: "First Shot")
            //    .frame(, alignment: .top)
            
//            ScrollView(.horizontal) {
//                HStack(alignment: .top, spacing: 20) {
//                    let fullyVaccinatedChartStyle = ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.green, textColor: .black, legendTextColor: .green, dropShadowColor: .black)
//
//                    LineView(data: fullyVaccinated, title: "Fully Vaccinated", legend: "US Population", style: fullyVaccinatedChartStyle, valueSpecifier: "%.0f", legendSpecifier: "%")
//
//                    let partiallyVaccinatedChartStyle = ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColors.bluPurpl, textColor: .black, legendTextColor: .blue, dropShadowColor: .black)
//
//                    LineView(data: partiallyVaccinated, title: "First Shot", legend: "US Population", style: partiallyVaccinatedChartStyle, valueSpecifier: "%.0f", legendSpecifier: "%")
//                }
//            }
            
            MultiLineChartView(data: [(partiallyVaccinated, GradientColors.blu), (fullyVaccinated, GradientColors.green)], title: "Shots", valueSpecifier: "%.0f")

            Spacer()
            
            Text("COVID-19 Vaccination Data (United States)")
                .font(.title)
            
            HStack(alignment: .bottom, spacing: nil) {
                Text("Vaccinations Initiated:")
                    .font(.headline)
                Text("\(initiatedPercentage)%")
            }
            
            HStack(alignment: .bottom, spacing: nil) {
                Text("Vaccinations Completed:")
                    .font(.headline)
                Text("\(completedPercentage)%")
            }
        }
        .padding(20)
        .onAppear(perform: loadCurrentData)
        .onAppear(perform: loadHistoricalData)
    }
    
    func loadCurrentData() {
        guard let url = URL(string: "https://api.covidactnow.org/v2/country/US.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb") else {
            print("[ERROR] Failed To Validate URL From String.")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let currentData = try? JSONDecoder().decode(CurrentData.self, from: data) {
                    DispatchQueue.main.async {
                        self.metrics = currentData.metrics
                        print("[DATA] [METRICS] \(metrics)")
                    }
                    
                    return
                }
            }
            
            print("[ERROR] Failed To Fetch Data. [MESSAGE] \(error?.localizedDescription ?? "Unknown Error.")")
        }.resume()
    }
    
    func loadHistoricalData() {
        
        let shortened = true
        
        guard let url = URL(string: "https://covid.ourworldindata.org/data/vaccinations/vaccinations.json") else {
            print("[ERROR] Failed To Validate URL From String.")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                let decoder = JSONDecoder()
                
                let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                if let vaccinations = try? decoder.decode(Vaccinations.self, from: data) {
                    DispatchQueue.main.async {
                        print("[vaccinations] \(vaccinations)")
                        let unitedStates = vaccinations.first { country in return country.country == "United States" }
                        guard let vaccineData = unitedStates?.data else {
                            print("[ERROR] Failed To Find 'United States' Data Entry.")
                            return
                        }
                        
                        if (shortened) {
                            let cutOffDate = Date().addingTimeInterval(-(61*24*60*60)/* 31 Days */)
                            let shortenedVaccineData = vaccineData.filter { data in return data.date > cutOffDate }
                            self.historical = shortenedVaccineData
                        }
                        else {
                            self.historical = vaccineData
                        }
                    }
                    
                    return
                }
            }
            
            print("[ERROR] Failed To Fetch Data. [MESSAGE] \(error?.localizedDescription ?? "Unknown Error.")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            metrics: Metrics(
                vaccinationsInitiatedRatio: 0.0,
                vaccinationsCompletedRatio: 0.0
            ),
            historical: [
                VaccineData(date: Date(), totalVaccinations: 0, peopleVaccinated: 0, totalVaccinationsPerHundred: 0.0, peopleVaccinatedPerHundred: 0.0, dailyVaccinations: 0, dailyVaccinationsPerMillion: 0, peopleFullyVaccinated: 0, peopleFullyVaccinatedPerHundred: 0.0, dailyVaccinationsRaw: 0)
            ]
        )
    }
}
