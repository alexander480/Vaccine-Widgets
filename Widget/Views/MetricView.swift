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
            VStack(alignment: .center, spacing: 10.0) {
                ZStack {

                    Circle()
                        .foregroundColor(self.color)

                    Text("\(self.percentage)%")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.top], 2.75)
                }.padding([.bottom], 2.75)
                
                Text(self.title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(self.color)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                
            }
            .padding()
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
