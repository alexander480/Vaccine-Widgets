//
//  SingleMetricView.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/26/21.
//

import WidgetKit
import SwiftUI

enum VaccineStatus: String {
    case completed = "Fully Vaccinated"
    case initiated = "Partially Vaccinated"
    case none = "Not Vaccinated"
}

struct SingleMetricView : View {
	@Binding var metrics: CurrentMetric
	var status: VaccineStatus
	var shouldShortenTitle: Bool
	
	init(metrics: Binding<CurrentMetric>, status: VaccineStatus, shouldShortenTitle: Bool = false) {
		self._metrics = metrics
		self.status = status
		self.shouldShortenTitle = shouldShortenTitle
	}
	
	init?(metrics: CurrentMetric, status: VaccineStatus, shouldShortenTitle: Bool = false) {
		self.init(metrics: Binding.constant(metrics), status: status, shouldShortenTitle: shouldShortenTitle)
	}
    
    var body: some View {
        let completedPercentage = Int(metrics.completed * 100)
        let initiatedPercentage = Int(metrics.initiated * 100)
        let nonePercentage = Int((1.0 - metrics.initiated) * 100)
        
        switch status {
            case .completed:
				let title = shouldShortenTitle ? "Completed" : "Fully Vaccinated"
                return MetricView(title: title, color: .green, percentage: completedPercentage)
            case .initiated:
				let title = shouldShortenTitle ? "Initiated" : "Partly Vaccinated"
                return MetricView(title: title, color: .blue, percentage: initiatedPercentage)
            case .none:
				let title = shouldShortenTitle ? "Unvaccinated" : "Not Vaccinated"
                return MetricView(title: title, color: .red, percentage: nonePercentage)
        }
    }
}

struct SingleMetricViewPreviews: PreviewProvider {
    static var previews: some View {
		let metrics = CurrentMetric(initiated: 0.0, completed: 0.0)
        
		SingleMetricView(metrics: metrics, status: .completed)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

