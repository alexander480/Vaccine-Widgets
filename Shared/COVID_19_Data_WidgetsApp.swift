//
//  COVID_19_Data_WidgetsApp.swift
//  Shared
//
//  Created by Alexander Lester on 6/9/21.
//

import SwiftUI

@main
struct COVID_19_Data_WidgetsApp: App {
    @ObservedObject var model = DataModel(isoCode: "USA")
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
