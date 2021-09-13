//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Lester on 6/9/21.
//

import Foundation
import ALExt
import SwiftUI

import SwiftUICharts

struct ContentView: View {
    @ObservedObject var model: DataModel = DataModel()
    
    var body: some View {
			
		VStack(alignment: .center) {
			ScrollView() {
				
				// ----
				// MARK: Current Metrics
				// ----
				
				HStack(alignment: .center, spacing: 0.0) {
					// MultiMetricView(metrics: self.$model.current)
					SingleMetricView(metrics: self.$model.current, status: VaccineStatus.completed, shouldShortenTitle: true)
					SingleMetricView(metrics: self.$model.current, status: VaccineStatus.initiated, shouldShortenTitle: true)
					SingleMetricView(metrics: self.$model.current, status: VaccineStatus.none, shouldShortenTitle: true)
				}
				.padding([.leading, .trailing])
				.frame(height: 150.0)
				.onAppear(perform: self.model.fetchCurrent)
				
				// ----
				// MARK: Historical Metrics
				// ----
				
				// Daily Vaccinations - Line Chart
				
//				let dailyVaccinationsTimeline: [Double] = self.model.historical.compactMap({ return $0.dailyVaccinations })
//				let dailyVaccinationsStyle = ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.blu, textColor: .blue, legendTextColor: .secondary, dropShadowColor: .gray)
				
				// let dailyVaccinationsTimeline: [Double] = self.model.vaccinationTrends.map { return $0.rollingAverage }
				let dailyVaccinationsTimeline: [Double] = self.model.vaccinationTrends.map { $0.rollingAverage }
				let dailyVaccinationsStyle = ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.blu, textColor: .blue, legendTextColor: .secondary, dropShadowColor: .gray)
				
				LineView(data: dailyVaccinationsTimeline, title: "Daily Vaccinations", legend: "Vaccinations Per Day", style: dailyVaccinationsStyle, valueSpecifier: "%.0lf\n", legendSpecifier: "%.0lf\n")
					.padding()
					.frame(width: UIScreen.main.bounds.width, height: 375, alignment: .top)
				
				// Daily Cases - Line Chart
				
				//let thirtyDaysAgo: Date = Date() - TimeInterval(86400 * 120)
				//let thisMonthData: [ActualData] = self.model.actuals.filter { return $0.date > thirtyDaysAgo}
				
				let dailyCasesTimeline = self.model.actuals.newCasesAverage
				let dailyCasesStyle = ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orngPink, textColor: .red, legendTextColor: .secondary, dropShadowColor: .gray)
				
				LineView(data: dailyCasesTimeline, title: "Daily Cases", legend: "Cases Per Day", style: dailyCasesStyle, valueSpecifier: "%.0lf\n", legendSpecifier: "%.0lf\n")
					.padding()
					.frame(width: UIScreen.main.bounds.width, height: 375, alignment: .top)
			}
			
		}
		.onAppear(perform: self.model.fetchVaccinationTrends)
		// .onAppear(perform: self.model.fetchHistorical)
		.onAppear(perform: self.model.fetchActuals)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model: DataModel = DataModel()
		ContentView(model: model)
    }
}
