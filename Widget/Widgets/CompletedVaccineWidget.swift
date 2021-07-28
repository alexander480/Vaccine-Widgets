//
//  CompletedVaccineWidget.swift
//  Vaccination Data
//
//  Created by Alexander Lester on 6/10/21.
//

import WidgetKit
import SwiftUI
// import SwiftUICharts

struct CompletedVaccineWidget: Widget {
    let kind: String = "CompletedVaccineWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in SingleMetricView(entry: entry, status: .completed) }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Fully Vaccinated")
            .description("This widget displays the percentage of fully vaccinated people in the United States.")
    }
}

struct CompletedVaccineWidgetPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = EntryHelper.createPlaceholder()
        
        SingleMetricView(entry: placeholderEntry, status: .completed)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
