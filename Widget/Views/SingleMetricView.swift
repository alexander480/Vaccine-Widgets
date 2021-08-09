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
    @Environment(\.widgetFamily) var size
    
    let entry: Entry
    var status: VaccineStatus
    
    var body: some View {
        let completedPercentage = Int(entry.metrics.completed * 100)
        let initiatedPercentage = Int(entry.metrics.initiated * 100)
        let nonePercentage = Int((1.0 - entry.metrics.initiated) * 100)
        
        switch status {
            case .completed:
                return MetricView(title: "Fully Vaccinated", color: .green, percentage: completedPercentage)
            case .initiated:
                return MetricView(title: "Partly Vaccinated", color: .blue, percentage: initiatedPercentage)
            case .none:
                return MetricView(title: "Not Vaccinated", color: .red, percentage: nonePercentage)
        }
    }
}

struct SingleMetricViewPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = EntryHelper.createPlaceholder()
        
        SingleMetricView(entry: placeholderEntry, status: .completed)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

