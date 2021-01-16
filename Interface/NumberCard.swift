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
    var evolutionRate: Double
    var color: Color
    var increasing: Bool = false

    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(label)
                    .fontWeight(.bold)
                    
                    .foregroundColor(Color(#colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1058823529, alpha: 1)))
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
                
            VStack(alignment: .leading) {
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Image(systemName: increasing ? "arrow.up.right" : "arrow.down.right")
                        .font(Font.system(size: 24, weight: .bold))
                    Spacer()
                        .frame(width: 6, height: 0)
                    Text(evolutionRate.kmFormatted)
                        .font(Font.system(size: 32, weight: .bold))
                        .fontWeight(.heavy)
                    Text("pts")
                        .font(Font.system(size: 10, weight: .regular, design: .rounded))
                }
                .foregroundColor(color)
                Spacer()
                    .frame(height: 6)
                Text("\(label) rate is ")
                    .font(Font.system(size: 10, weight: .regular))
                    .foregroundColor(Color(#colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.537254902, alpha: 1)))
                    + Text(increasing ? "increasing" : "decreasing")
                        .foregroundColor(Color(#colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.537254902, alpha: 1)))
                        .font(Font.system(size: 10, weight: .regular))
                        .bold()
                        
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .topLeading)
            .padding(.vertical, 18)
            .padding(.horizontal, 14)
            .overlay(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)), style: StrokeStyle(lineWidth: 0.5)))
            .background(RoundedRectangle(cornerRadius: 14.0)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0.0, y: 4.0))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    @State static var value1 = 2022239.0
    @State static var value2 = 25126.0
    
    static var previews: some View {
        VStack {
            
            HStack {
                NumberCard(value: value1, label: "Deaths", evolutionRate: 3.9, color: Color.hardRed)
                    
                NumberCard(value: value2, label: "Recoveries", evolutionRate: 103.5, color: Color.hardGreen)
            }
            HStack {
                NumberCard(value: value1, label: "Deaths", evolutionRate: 3.9, color: Color.hardRed)
                    
                NumberCard(value: value2, label: "Recoveries", evolutionRate: 103.5, color: Color.hardGreen)
            }
           // NumberCard(value: value2, label: "Recovery", evolutionRate: -1.3, color: Color.mainPurple)
            
        }
        .previewDevice("iPhone 12")
        .frame(height: 260)
        .padding()
        
    }
}
