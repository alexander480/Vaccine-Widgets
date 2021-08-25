//
//  InitiatedVaccineWidget.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import WidgetKit
import SwiftUI

struct InitiatedVaccineWidget: Widget {
    let kind: String = "InitiatedVaccineWidget"

    var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in SingleMetricView(metrics: entry.metrics, status: .initiated) }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Partially Vaccinated")
            .description("This widget displays the percentage of partially vaccinated people in the United States.")
    }
}

struct InitiatedVaccineWidgetPreviews: PreviewProvider {
    static var previews: some View {
        let entry = EntryHelper.createPlaceholder()
        
		SingleMetricView(metrics: entry.metrics, status: .initiated)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
