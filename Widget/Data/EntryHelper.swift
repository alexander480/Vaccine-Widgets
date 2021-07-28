//
//  EntryHelper.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/26/21.
//

import WidgetKit
import SwiftUI

struct EntryHelper {
    static func createPlaceholder() -> Entry {
        let placeholderMetrics = CurrentMetric(initiated: 0.0, completed: 0.0)
        let placeholderEntry = Entry(date: Date(), metrics: placeholderMetrics)
        
        return placeholderEntry
    }
    
    static func createEntry(_ entryDate: Date = Date(), completion: @escaping (Entry) -> ()) {
        let url = URL(string: "https://api.covidactnow.org/v2/country/US.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let currentData = try JSONDecoder().decode(CurrentData.self, from: data)
                    let entry = Entry(date: Date(), metrics: currentData.metrics)
                    
                    print("[WIDGET] [SUCCESS] Successfully Validated Current Data. [DATA] \(currentData.metrics)")
                    
                    completion(entry)
                }
                catch let decodeError {
                    let placeholderMetrics = CurrentMetric(initiated: 0.0, completed: 0.0)
                    let entry = Entry(date: Date(), metrics: placeholderMetrics)
                    
                    print("[WIDGET] [ERROR] Failed To Decode Current Data. [MESSAGE] \(decodeError.localizedDescription).")
                    
                    completion(entry)
                }
            } else if let error = error {
                let placeholderMetrics = CurrentMetric(initiated: 0.0, completed: 0.0)
                let entry = Entry(date: Date(), metrics: placeholderMetrics)
                
                print("[WIDGET] [ERROR] Failed To Validate Current Data. [MESSAGE] \(error.localizedDescription).")
                
                completion(entry)
            }
        }.resume()
    }
}
