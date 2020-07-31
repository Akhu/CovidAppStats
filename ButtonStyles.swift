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
            .background(buttonShape
                            .fill(Color.teal)                        
            )
            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
            .overlay(
                buttonShape.stroke(Color.teal.opacity(0.4), lineWidth: 2)
            )
                  
                            
    }
    
    
}


struct OutlineButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(Font.TextStyle.callout, design: .rounded))
            .foregroundColor(.black)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(buttonShape.stroke())
            
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
 
