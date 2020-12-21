//
//  SwiftUIView.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 20/12/2020.
//

import SwiftUI
import SwiftUICharts

struct NumberCardWithChart: View {
    var value: Double?
    var label: String
    var evolutionRate: Double = 1.0
    var color: Color
    var increasing: Bool = false

    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(label)
                    .fontWeight(.bold)
                Spacer()
                Text(value?.kmFormatted ?? 0.0.kmFormatted)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color(#colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)))
                    .background(RoundedRectangle(cornerRadius: 50.0)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))))
            }
            HStack {
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: increasing ? "arrow.up.right" : "arrow.down.right")
                            .font(.system(size: 24))
                        Text(evolutionRate.kmFormatted)
                            .font(.title)
                            .fontWeight(.heavy)
                        Text("pts")
                            .font(.caption2)
                            
                    }
                    .foregroundColor(color)
                    Spacer()
                        .frame(height: 6)
                    Text("\(label) rate is ")
                        .font(.caption2)
                        .foregroundColor(Color(#colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)))
                        + Text(increasing ? "increasing" : "decreasing")
                            .foregroundColor(Color(#colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)))
                            .font(.caption2)
                            .bold()
                }
                //Todo : Le graph sans les chiffres mais avec le magnifier idéalement
                //Line(data: [102547858.kmFormattedDouble,106547858.kmFormattedDouble,105547858.kmFormattedDouble,112547858.kmFormattedDouble])
                    
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .topLeading)
            .padding(.vertical, 18)
            .padding(.horizontal, 12)
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)), style: StrokeStyle(lineWidth: 0.5)))
            .background(RoundedRectangle(cornerRadius: 14.0)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0.0, y: 4.0))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
}

struct NumberCardWithChart_Previews: PreviewProvider {
    static var previews: some View {
        NumberCardWithChart(value: 15200156, label: "Recovery", evolutionRate: 103.5, color: Color.hardGreen)
    }
}
