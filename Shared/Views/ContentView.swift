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
    @ObservedObject var model: DataModel = DataModel()
    
    var body: some View {
			
		VStack(alignment: .center) {
			ScrollView() {
				
				// ----
				// MARK: Current Metrics
				// ----
				
				HStack(alignment: .center, spacing: 0.0) {
					SingleMetricView(metrics: self.$model.current, status: VaccineStatus.completed, shouldShortenTitle: true)
					SingleMetricView(metrics: self.$model.current, status: VaccineStatus.initiated, shouldShortenTitle: true)
					SingleMetricView(metrics: self.$model.current, status: VaccineStatus.none, shouldShortenTitle: true)
				}
				.padding([.leading, .trailing])
				.frame(height: 150.0)
				.onAppear(perform: self.model.fetchCurrent)
				
				let dailyVaccinationsTimeline: [Double] = dailyVaccinationsThisMonth.dailyVaccinationsAverage
				let dailyVaccinationsStyle = ChartStyle(backgroundColor: .black, accentColor: .blue, gradientColor: GradientColors.blu, textColor: .blue, legendTextColor: .blue, dropShadowColor: .gray)
				
				LineView(data: dailyVaccinationsTimeline, title: "Daily Vaccinations", legend: "Vaccinations Per Day", style: dailyVaccinationsStyle, valueSpecifier: "%.0lf\n", legendSpecifier: "%.0lf\n")
					.padding()
					.frame(width: UIScreen.main.bounds.width, height: 375, alignment: .top)

				let dailyCasesTimeline = self.model.actuals.newCasesAverage
				let dailyCasesStyle = ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orngPink, textColor: .red, legendTextColor: .secondary, dropShadowColor: .gray)
				
				LineView(data: dailyCasesTimeline, title: "Daily Cases", legend: "Cases Per Day", style: dailyCasesStyle, valueSpecifier: "%.0lf\n", legendSpecifier: "%.0lf\n")
					.padding()
					.frame(width: UIScreen.main.bounds.width, height: 375, alignment: .top)
			}
			
		}
		.onAppear(perform: self.model.fetchVaccinationTrends)
		.onAppear(perform: self.model.fetchActuals)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model: DataModel = DataModel()
		ContentView(model: model)
    }
}
