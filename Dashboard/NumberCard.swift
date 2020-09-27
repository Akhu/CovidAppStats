//
//  SwiftUIView.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 27/09/2020.
//

import SwiftUI



struct NumberCard: View {
    @State var value: Int
    var label: String
    var color: Color
    var labelColor: Color
    
    var body: some View {
        ZStack{
            withAnimation {
                Text(String(describing: value)).animation(.spring())
            .font(.system(size: 34, weight: Font.Weight.black, design: .default))
            .foregroundColor(.white)
            .padding(EdgeInsets(
            top: 32, leading: 12, bottom: 32, trailing: 12))
            .background(
                RoundedRectangle(cornerRadius: 14.0, style: .continuous).fill(color)
                )
            .overlay(
                Text(label)
                    .font(.system(size: 12, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(labelColor))
                    .offset(y: 55)
                    .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0.0, y: 9)
                    .shadow(color: Color.black.opacity(0.09), radius: 4, x: 0.0, y: 2)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0.0, y: 1)
                )
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NumberCard(value: 1234567668, label: "Recovery", color: Color.teal, labelColor: Color.tealShadow)
    }
}
