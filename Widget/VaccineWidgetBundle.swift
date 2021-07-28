//
//  VaccineWidgetBundle.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import SwiftUI
import WidgetKit

@main
struct VaccineWidgetBundle: WidgetBundle {
    var body: some Widget {
        // - Small
        CompletedVaccineWidget()
        InitiatedVaccineWidget()
        NoneVaccineWidget()
        
       // - Medium
        MultiMetricWidget()
    }
}
