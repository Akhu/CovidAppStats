//
//  SwiftUIView.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 27/09/2020.
//

import SwiftUI



struct NumberCard: View {
    var value: Double?
    var label: String
    var color: Color
    var labelColor: Color

    
    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                Text(value?.kmFormatted ?? 0.0.kmFormatted).animation(.spring())
                    .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.4: geometry.size.height * 0.35, weight: Font.Weight.black, design: .default))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 24, leading: 12, bottom: 24, trailing: 12))
                    .background(RoundedRectangle(cornerRadius: 14.0, style: .continuous).fill(color))
                }
                Text(label)
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(labelColor))
                    .offset(y: -25)
                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 9)
                    .shadow(color: Color.black.opacity(0.09), radius: 4, x: 0.0, y: 2)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0.0, y: 1)
                    .unredacted()
                }
        }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    @State static var value1 = 20239.0
    @State static var value2 = 2516.0
    
    static var previews: some View {
        HStack {
            NumberCard(value: value1, label: "Recovery", color: Color.teal, labelColor: Color.tealShadow)
                
            NumberCard(value: value2, label: "Recovery", color: Color.teal, labelColor: Color.tealShadow)
        }
        .frame(height: 130)
        .padding()
        
    }
}
