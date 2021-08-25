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
    
    @Binding var percentage: Int
	
	var radius: Double = 0.0
	
	init(title: String, color: Color, percentage: Binding<Int>) {
		self.title = title
		self.color = color
		self._percentage = percentage
	}
	
	init?(title: String, color: Color, percentage: Int) {
		let bindablePercentage = Binding.constant(percentage)
		self.init(title: title, color: color, percentage: bindablePercentage)
	}
    
    var body: some View {
        // - Fully Vaccinated
        HStack(alignment: .top) {
            VStack(alignment: .center, spacing: 10.0) {
                ZStack {
					
					Circle()
						.foregroundColor(self.color)
						
					
//					CurvedText(text: "Fully Vacinated", radius: 55)
//						.rotationEffect(Angle(degrees: 0))
//						.font(.callout)
//
//						.foregroundColor(.white)
//						.multilineTextAlignment(.center)
//						.padding([.top], 3.0)
					

                    Text("\(self.percentage)%")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.top], 3.0)
                }.padding([.bottom], 2.0)
                
				
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
