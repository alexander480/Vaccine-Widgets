//
//  EntryDataHelper.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/26/21.
//

import WidgetKit
import SwiftUI

struct EntryDataHelper {
    static func createTimelineEntry(completion: @escaping (EntryData) -> ()) {
        let url = URL(string: "https://api.covidactnow.org/v2/country/US.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let currentData = try JSONDecoder().decode(CurrentData.self, from: data)
                    let entry = EntryData(date: Date(), current: currentData.metrics)
                    
                    print("[WIDGET] [SUCCESS] Successfully Validated Current Data. [DATA] \(currentData.metrics)")
                    
                    completion(entry)
                }
                catch let decodeError {
                    let placeholderMetrics = CurrentMetric(initiated: 0.0, completed: 0.0)
                    let entry = EntryData(date: Date(), current: placeholderMetrics)
                    
                    print("[WIDGET] [ERROR] Failed To Decode Current Data. [MESSAGE] \(decodeError.localizedDescription).")
                    
                    completion(entry)
                }
            } else if let error = error {
                let placeholderMetrics = CurrentMetric(initiated: 0.0, completed: 0.0)
                let entry = EntryData(date: Date(), current: placeholderMetrics)
                
                print("[WIDGET] [ERROR] Failed To Validate Current Data. [MESSAGE] \(error.localizedDescription).")
                
                completion(entry)
            }
        }.resume()
    }
}
