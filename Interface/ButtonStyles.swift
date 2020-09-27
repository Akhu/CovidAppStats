//
//  ButtonStyle.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 31/07/2020.
//

import Foundation
import SwiftUI

let buttonShape = RoundedRectangle(cornerRadius: 14.0, style: .continuous)

struct FlatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.system(Font.TextStyle.callout, design: .rounded))
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(configuration.isPressed ? buttonShape.fill(Color.tealShadow) : buttonShape
                            .fill(Color.teal)                        
            )
            .shadow(color: configuration.isPressed ? Color.black.opacity(0.1) : Color.black.opacity(0.06), radius: configuration.isPressed ? 2 : 4, x: 0, y: 2)
            .overlay(
                buttonShape.stroke(Color.teal.opacity(0.4), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .rotation3DEffect(
                .degrees(configuration.isPressed ? 3: 0),
                axis: (x: -5.0, y: 0.0, z: 0.0))
                            
    }
    
    
}


struct OutlineButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .font(.system(Font.TextStyle.callout, design: .rounded))
                .foregroundColor(configuration.isPressed ? Color.white : Color.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            .background(configuration.isPressed ? buttonShape.fill(Color.black) : buttonShape.fill(Color.white))
            .overlay(configuration.isPressed ? buttonShape.stroke(lineWidth: 2) : buttonShape.stroke())
            
        
    }
    
}


struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(spacing: 20) {
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "hand.raised")
                    Text("Hello Button")
                }
            }).buttonStyle(OutlineButtonStyle())
            
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "phone")
                    Text("Hello Button")
                }
            }).buttonStyle(FlatButtonStyle())
        }
    }
}
 
