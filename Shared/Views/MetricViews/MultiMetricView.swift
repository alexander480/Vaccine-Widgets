//
//  MultiMetricView.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import WidgetKit
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct StatefulPreviewWrapper<Value, Content: View>: View {
	@State var value: Value
	var content: (Binding<Value>) -> Content
	
	public var body: some View {
		content($value)
	}
	
	public init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
		self._value = State(wrappedValue: value)
		self.content = content
	}
}

struct MultiMetricView: View {
    @Binding var metrics: CurrentMetric
	
	init(metrics: Binding<CurrentMetric>) { self._metrics = metrics }
	init?(metrics: CurrentMetric) { self.init(metrics: Binding.constant(metrics)) }
    
    var body: some View {
        let completedPercentage = Int(metrics.completed * 100)
        let initiatedPercentage = Int(metrics.initiated * 100)
        let nonePercentage = Int((1.0 - metrics.initiated) * 100)

        HStack(alignment: .center) {
            
            MetricView(title: "Fully Vaccinated", color: .green, percentage: completedPercentage)
                .padding(.all, 6.0)
            
            Divider()
            
            MetricView(title: "Partly Vaccinated", color: .blue, percentage: initiatedPercentage)
                .padding(.all, 6.0)
            
			// Divider()
			
            // MetricView(title: "Unvaccinated", color: .red, percentage: nonePercentage)
                //.padding(.all, 6.0)
                
        }
    }
}

struct MultiMetricViewPreviews: PreviewProvider {
    static var previews: some View {
		let metricsBinding = Binding.constant(CurrentMetric(initiated: 0.0, completed: 0.0))
		
		MultiMetricView(metrics: metricsBinding)
			.previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
