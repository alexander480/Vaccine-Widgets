//
//  MultiMetricView.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import WidgetKit
import SwiftUI

struct MultiMetricView: View {
    let entry: Entry
    
    var body: some View {
        let completedPercentage = Int(entry.metrics.completed * 100)
        let initiatedPercentage = Int(entry.metrics.initiated * 100)
        // let nonePercentage = Int((1.0 - entry.metrics.initiated) * 100)

        HStack(alignment: .center) {
            
            MetricView(title: "Fully Vaccinated", color: .green, percentage: completedPercentage)
                .padding(.all, 8.0)
            
            Divider()
            
            MetricView(title: "Partly Vaccinated", color: .blue, percentage: initiatedPercentage)
                .padding(.all, 8.0)
            
//            MetricView(title: "Not Vaccinated", color: .red, percentage: nonePercentage)
//                .padding(.all, 0.0)
                
        }
    }
}

struct MultiMetricViewPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = EntryHelper.createPlaceholder()
        
        MultiMetricView(entry: placeholderEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
