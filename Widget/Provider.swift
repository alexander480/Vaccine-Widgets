//
//  Provider.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/26/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Entry { return EntryHelper.createPlaceholder() }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) { completion(EntryHelper.createPlaceholder()) /* EntryHelper.createEntry { entry in completion(entry) } */ }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [Entry] = []
        
        let currentDate = Date()
        EntryHelper.createEntry { entry in
            entries.append(entry)
            let loadAfterDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
            let timeline = Timeline(entries: entries, policy: .after(loadAfterDate))
            
            completion(timeline)
        }
        
        
    }
}
