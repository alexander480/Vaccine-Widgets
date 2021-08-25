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
        VStack(alignment: .leading) {
            
            // MARK: Current Metrics
            
			HStack(alignment: .top) {
				SingleMetricView(metrics: self.$model.current, status: VaccineStatus.completed, shouldShortenTitle: true)
				SingleMetricView(metrics: self.$model.current, status: VaccineStatus.initiated, shouldShortenTitle: true)
				SingleMetricView(metrics: self.$model.current, status: VaccineStatus.none, shouldShortenTitle: true)
			}
			.frame(width: UIScreen.main.bounds.width, height: 150, alignment: .bottom)
			.onAppear(perform: self.model.fetchCurrent)

            // MARK: Historical Metrics
            
			let completedTimeline: [Double] = self.model.historical.compactMap({ return $0.peopleFullyVaccinatedPerHundred })
            let initiatedTimeline: [Double] = self.model.historical.compactMap({ return $0.peopleVaccinatedPerHundred })
            let unvaccinatedTimeline: [Double] = initiatedTimeline.compactMap({ return (100.0 - $0) })
            
            // let totalVaccinationsTimeline: [Double] = self.model.historical.compactMap({ return $0.totalVaccinations })
            
            // ScrollView(.horizontal, showsIndicators: false) {
                
            HStack(alignment: .center) {
                ScrollView() {
                    VStack(alignment: .leading) {
                        
                        let chartWidth = (UIScreen.main.bounds.width)
                        
                        let greenGradient = GradientColor(start: .green, end: .green)
                        let blueGradient = GradientColor(start: .blue, end: .blue)
                        let redGradient = GradientColor(start: .red, end: .red)
                        
                        // -- Fully Vaccinated - Line Chart
                        let fullyVaccinatedStyle = ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: greenGradient, textColor: .green, legendTextColor: .green, dropShadowColor: .gray)
                        LineView(data: completedTimeline, title: "Fully Vaccinated", legend: "US Population", style: fullyVaccinatedStyle, valueSpecifier: "%.0f%%", legendSpecifier: "%.0f%%")
                            .padding([.leading, .trailing])
                            .frame(width: chartWidth, height: 360, alignment: .top)
                        
                        // -- Partially Vaccinated - Line Chart
                        let partiallyVaccinatedStyle = ChartStyle(backgroundColor: .white, accentColor: .orange, gradientColor: blueGradient, textColor: .blue, legendTextColor: .blue, dropShadowColor: .gray)
                        LineView(data: initiatedTimeline, title: "Partially Vaccinated", legend: "US Population", style: partiallyVaccinatedStyle, valueSpecifier: "%.0f%%", legendSpecifier: "%.0f%%")
                            .padding([.leading, .trailing])
                            .frame(width: chartWidth, height: 360, alignment: .top)
                        
                        // -- Not Vaccinated - Line Chart
                        let unvaccinatedStyle = ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: redGradient, textColor: .red, legendTextColor: .red, dropShadowColor: .gray)
                        LineView(data: unvaccinatedTimeline, title: "Not Vaccinated", legend: "US Population", style: unvaccinatedStyle, valueSpecifier: "%.0f%%", legendSpecifier: "%.0f%%")
                            .padding([.leading, .trailing])
                            .frame(width: chartWidth, height: 360, alignment: .top)
                    }
                }
			}.onAppear(perform: self.model.fetchHistorical)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model: DataModel = DataModel()
        ContentView(model: model)
    }
}
