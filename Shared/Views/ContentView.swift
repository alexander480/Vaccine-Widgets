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
            
            // MARK: Current Metrics
            // ----
			
			HStack(alignment: .center) {
				SingleMetricView(metrics: self.$model.current, status: VaccineStatus.completed, shouldShortenTitle: true)
				SingleMetricView(metrics: self.$model.current, status: VaccineStatus.initiated, shouldShortenTitle: true)
				SingleMetricView(metrics: self.$model.current, status: VaccineStatus.none, shouldShortenTitle: true)
			}
			
			.padding([.leading, .trailing])
			.frame(width: UIScreen.main.bounds.width, height: 145, alignment: .center)
			.onAppear(perform: self.model.fetchCurrent)
			
            // MARK: Historical Metrics
            // ----
                
			HStack(alignment: .top) {
				
				// Daily Vaccinations - Line Chart
				// ----
				
				let dailyVaccinationsTimeline: [Double] = self.model.historical.compactMap({ return $0.dailyVaccinations })
				let dailyVaccinationsStyle = ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColors.blu, textColor: .blue, legendTextColor: .secondary, dropShadowColor: .gray)
				
				LineView(data: dailyVaccinationsTimeline, title: "Daily Vaccinations", legend: "Vaccinations Per Day", style: dailyVaccinationsStyle, valueSpecifier: "%.0lf\n", legendSpecifier: "%.0lf\n")
                
			}
			.padding([.leading, .trailing])
			.onAppear(perform: self.model.fetchHistorical)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model: DataModel = DataModel()
		ContentView(model: model)
    }
}
