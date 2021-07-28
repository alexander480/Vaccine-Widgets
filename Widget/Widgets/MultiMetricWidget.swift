//
//  MultiMetricWidget.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import WidgetKit
import SwiftUI

struct MultiMetricWidget: Widget {
    let kind: String = "MultiMetricWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in MultiMetricView(entry: entry) }
            .supportedFamilies([.systemMedium])
            .configurationDisplayName("Vaccinations")
            .description("This widget displays vaccination data for the United States.")
    }
}

struct MultiMetricWidgetPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = EntryHelper.createPlaceholder()
        
        MultiMetricView(entry: placeholderEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
