//
//  VaccineWidget.swift
//  Vaccination Data
//
//  Created by Alexander Lester on 6/10/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> VaccineDataEntry {
        let placeholderMetrics = WidgetMetrics(vaccinationsInitiatedRatio: 0.0, vaccinationsCompletedRatio: 0.0)
        let placeholderEntry = VaccineDataEntry(date: Date(), metrics: placeholderMetrics)
        
        return placeholderEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (VaccineDataEntry) -> ()) {
        WidgetHelper.loadData { metrics in
            let entry = VaccineDataEntry(date: Date(), metrics: metrics)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VaccineDataEntry>) -> ()) {
        WidgetHelper.loadData { metrics in
            var entries: [VaccineDataEntry] = []
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!

                    let entry = VaccineDataEntry(date: entryDate, metrics: metrics)
                    entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct VaccineWidgetEntryView : View {
    let entry: VaccineDataEntry

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            let initiatedPercentage = Int(entry.metrics.vaccinationsInitiatedRatio * 100)
            Text("\(initiatedPercentage)%")
            
            let completedPercentage = Int(entry.metrics.vaccinationsCompletedRatio * 100)
            Text("\(completedPercentage)%")
            
            Spacer()
        }
        
    }
}

@main
struct VaccineWidget: Widget {
    let kind: String = "VaccineWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            VaccineWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Vaccine Widget")
        .description("This is an example widget.")
    }
}

struct VaccineWidgetPreviews: PreviewProvider {
    static var previews: some View {
        let placeholderEntry = VaccineDataEntry(date: Date(), metrics: WidgetMetrics(vaccinationsInitiatedRatio: 0.0, vaccinationsCompletedRatio: 0.0))
        
        VaccineWidgetEntryView(entry: placeholderEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
