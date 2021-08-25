//
//  VaccineApp.swift
//  Shared
//
//  Created by Alexander Lester on 6/9/21.
//

import SwiftUI

@main
struct VaccineApp: App {
    @ObservedObject var model = DataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
