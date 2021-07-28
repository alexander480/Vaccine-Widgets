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
        StaticConfiguration(kind: kind, provider: Provider()) { entry in SingleMetricView(entry: entry, status: .initiated) }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Partially Vaccinated")
            .description("This widget displays the percentage of partially vaccinated people in the United States.")
    }
}

struct InitiatedVaccineWidgetPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = EntryHelper.createPlaceholder()
        
        SingleMetricView(entry: placeholderEntry, status: .initiated)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
