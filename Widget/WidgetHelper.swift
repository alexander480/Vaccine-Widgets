//
//  WidgetData.swift
//  Vaccination DataExtension
//
//  Created by Alexander Lester on 6/10/21.
//

import Foundation
import WidgetKit

struct WidgetResponse: Codable {
    let metrics: WidgetMetrics
}

struct WidgetMetrics: Codable {
    // var testPositivityRatio: Double
    // var infectionRate: Double
    let vaccinationsInitiatedRatio: Double
    let vaccinationsCompletedRatio: Double
}

struct VaccineDataEntry: TimelineEntry {
    let date: Date
    let metrics: WidgetMetrics
}

struct WidgetHelper {
    static func loadData(completion: @escaping (WidgetMetrics) -> ()) {
        
        var metrics: WidgetMetrics = WidgetMetrics(vaccinationsInitiatedRatio: 0.0, vaccinationsCompletedRatio: 0.0)
        
        guard let url = URL(string: "https://api.covidactnow.org/v2/country/US.json?apiKey=ce6514b87dc446568ccde9f609dbe8cb") else {
            print("[ERROR] Failed To Validate URL From String.")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("[ERROR] Failed To Fetch Data. [MESSAGE] \(error?.localizedDescription ?? "Unknown Error.")");
                return
            }
            
            print("[DATA] \(data)")
            
            do {
                let response = try JSONDecoder().decode(WidgetResponse.self, from: data)
                
                print("[JSON] [DATA] \(data)")
                
                metrics = response.metrics
                print("[METRICS] [DATA] [METRICS] \(metrics)")
            }
            catch {
                print("[ERROR] Failed To Decode Data.")
            }

            completion(metrics)
            
        }.resume()
    }
}
