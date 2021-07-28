//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Lester on 6/9/21.
//

import Foundation
import SwiftUI

import SwiftUICharts
import SwiftPieChart

struct ContentView: View {
    @ObservedObject var model: DataModel = DataModel(isoCode: "USA")
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Current Metrics
            
            let completedPercentage = Int(self.model.current.completed * 100)
            let initiatedPercentage = Int(self.model.current.initiated * 100)
            let unvaccinatedPercentage = Int((1.0 - self.model.current.initiated) * 100)
            
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 8.0) {
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
                        
                    }.padding()
                }
                
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 8.0) {
                        ZStack {
                            Circle()
                                .foregroundColor(.blue)
                            
                            Text("\(initiatedPercentage)%")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("Vaccinated")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                        
                    }.padding()
                }
                
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 8.0) {
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
                        
                    }.padding()
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
                        
                        let chartHeight = (UIScreen.main.bounds.height - 210 /*Metric View */) / 2
                        let chartWidth = (UIScreen.main.bounds.width)

                        let lineViewGradient = GradientColor(start: Color(.yellow), end: Color(.green))
                        let lineViewStyle = ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: lineViewGradient, textColor: .green, legendTextColor: .green, dropShadowColor: .gray)
                    LineView(data: initiatedTimeline, title: "Vaccinations", legend: "US Population", style: lineViewStyle, valueSpecifier: "%.0f%%", legendSpecifier: "%.0f%%")
                        .padding([.leading, .trailing])
                        .frame(width: chartWidth, height: 360, alignment: .top)
                        
                        let lineViewGradient2 = GradientColor(start: Color(.red), end: Color(.orange))
                        let lineViewStyle2 = ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: lineViewGradient2, textColor: .red, legendTextColor: .red, dropShadowColor: .gray)
                        LineView(data: unvaccinatedTimeline, title: "Cases", legend: "Reported Cases", style: lineViewStyle2, valueSpecifier: "%.0f%%", legendSpecifier: "%.0f%%")
                            .padding([.leading, .trailing])
                        .frame(width: chartWidth, height: 360, alignment: .top)
                    }
                }
                //.frame(width: UIScreen.main.bounds.width, height: ((360 * 2)), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                

//                    let redGradient = GradientColor(start: Color(.red), end: .orange)
//                    let orangeGradient = GradientColor(start: Color(.orange), end: Color(.yellow))
//                    let greenGradient = GradientColor(start: Color(.yellow), end: Color(.green))
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
//                    // -- Fully Vaccinated - Line Chart
//                    let fullyVaccinatedStyle = ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: greenGradient, textColor: .green, legendTextColor: .green, dropShadowColor: .gray)
//                    LineChartView(data: completedTimeline, title: "Vaccinated", style: fullyVaccinatedStyle, dropShadow: true)
//                        .padding()
//                        .disabled(true)
//
//                    // -- Partially Vaccinated - Line Chart
//                    let partiallyVaccinatedStyle = ChartStyle(backgroundColor: .white, accentColor: .orange, gradientColor: orangeGradient, textColor: .orange, legendTextColor: .orange, dropShadowColor: .gray)
//                    LineChartView(data: initiatedTimeline, title: "Partially Protected", style: partiallyVaccinatedStyle, dropShadow: true)
//                        .padding()
//                        .disabled(true)
//
//                    // -- Not Vaccinated - Line Chart
//                    let unvaccinatedStyle = ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: redGradient, textColor: .red, legendTextColor: .red, dropShadowColor: .gray)
//                    LineChartView(data: unvaccinatedTimeline, title: "Not Vaccinated", legend: "Legend", style: unvaccinatedStyle, dropShadow: true)
//                        .padding()
//                        .disabled(true)
                }
        }
        
            
            
        //}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model: DataModel = DataModel(isoCode: "USA")
        
        ContentView(model: model)
    }
}
