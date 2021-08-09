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
    @ObservedObject var model: DataModel = DataModel(isoCode: "USA")
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Current Metrics
            
            let completedPercentage = Int(self.model.current.completed * 100)
            let initiatedPercentage = Int(self.model.current.initiated * 100)
            let unvaccinatedPercentage = Int((1.0 - self.model.current.initiated) * 100)
            
            HStack(alignment: .top) {
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 16.0) {
                        ZStack {
                            Circle()
                                .foregroundColor(.green)
                            
                            Text("\(completedPercentage)%")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("Fully Vaccinated")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        
                    }
                    .padding(.all, 10.0)
                }
                
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 16.0) {
                        ZStack {
                            Circle()
                                .foregroundColor(.blue)
                            
                            Text("\(initiatedPercentage)%")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("Partly Vaccinated")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            
                        
                    }
                    .padding(.all, 10.0)
                }
                
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 16.0) {
                        ZStack {
                            Circle()
                                .foregroundColor(.red)
                            
                            Text("\(unvaccinatedPercentage)%")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("Not Vaccinated")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        
                    }
                    .padding([.all], 10.0)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .bottom)

            
            
            // -- Text
//            Group {
//                Text("COVID-19 Vaccination Data (United States)").font(.title)
//
//                HStack(alignment: .bottom, spacing: nil) {
//                    Text("Vaccinations Completed:").font(.headline)
//                    Text("\(completedPercentage)%")
//                }
//
//                HStack(alignment: .bottom, spacing: nil) {
//                    Text("Vaccinations Initiated:").font(.headline)
//                    Text("\(initiatedPercentage)%")
//                }
//
//                HStack(alignment: .bottom, spacing: nil) {
//                    Text("Not Vaccinated:").font(.headline)
//                    Text("\(unvaccinatedPercentage)%")
//                }
//            }
            
            // MARK: Historical Metrics
            
            let completedTimeline: [Double] = self.model.historical.compactMap({ return $0.peopleFullyVaccinatedPerHundred })
            let initiatedTimeline: [Double] = self.model.historical.compactMap({ return $0.peopleVaccinatedPerHundred })
            let unvaccinatedTimeline: [Double] = initiatedTimeline.compactMap({ return (100.0 - $0) })
            
            let totalVaccinationsTimeline: [Double] = self.model.historical.compactMap({ return $0.totalVaccinations })
            
            //ScrollView(.horizontal, showsIndicators: false) {
                
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
                //.frame(width: UIScreen.main.bounds.width, height: ((360 * 2)), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                

                    
//                    // let pinkGradient = GradientColor(start: .orange, end: .pink)
//
//                    // -- Total Vaccinations - Line Chart
//                    let lineChartStyle = ChartStyle(backgroundColor: .secondary, accentColor: .green, gradientColor: greenGradient, textColor: .primary, legendTextColor: .green, dropShadowColor: .gray)
//                    LineChartView(data: totalVaccinationsTimeline, title: "Total Vaccinations", legend: "Legendary", style: lineChartStyle, rateValue: nil, dropShadow: false, valueSpecifier: "%10d")
//
//                    // -- Completed vs. Initiated vs. Unvaccinated - Multi-Line Chart
//                    MultiLineChartView(data: [(unvaccinatedTimeline, redGradient), (initiatedTimeline, orangeGradient), (completedTimeline, greenGradient)], title: "Shots", dropShadow: true, valueSpecifier: "%8.4f")
//                        .padding()
//
//
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model: DataModel = DataModel(isoCode: "USA")
        
        ContentView(model: model)
    }
}
