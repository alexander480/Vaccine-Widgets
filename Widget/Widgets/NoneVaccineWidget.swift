//
//  NoneVaccineWidget.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import WidgetKit
import SwiftUI

struct NoneVaccineWidget: Widget {
    let kind: String = "NoneVaccineWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in SingleMetricView(entry: entry, status: .none) }
            .supportedFamilies([.systemSmall])
            .configurationDisplayName("Not Vaccinated")
            .description("This widget displays the percentage of non-vaccinated people in the United States.")
    }
}

struct NoneVaccineWidgetPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = EntryHelper.createPlaceholder()
        
        SingleMetricView(entry: placeholderEntry, status: .none)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
