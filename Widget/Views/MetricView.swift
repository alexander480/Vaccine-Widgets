//
//  MetricView.swift
//  Vaccine Widget
//
//  Created by Alexander Lester on 7/27/21.
//

import SwiftUI
import WidgetKit

struct MetricView: View {
    @State var title: String
    @State var color: Color
    
    @State var percentage: Int
    
    var body: some View {
        // - Fully Vaccinated
        HStack(alignment: .top) {
            VStack(alignment: .center, spacing: 8.0) {
                ZStack {
                    Circle()
                        .foregroundColor(self.color)

                    Text("\(self.percentage)%")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                Text(self.title)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(self.color)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
            }.padding()
        }
    }
}

struct MetricView_Previews: PreviewProvider {
    static var previews: some View {
        MetricView(title: "Fully Vaccinated", color: .green, percentage: 20)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        MetricView(title: "Partly Vaccinated", color: .blue, percentage: 20)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        MetricView(title: "Not Vaccinated", color: .red, percentage: 20)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
