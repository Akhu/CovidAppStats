//
//  Header.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 27/09/2020.
//

import SwiftUI

struct HeaderSection: View {
    let button1Action: () -> ()
    let button2Action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Feeling sick?")
                    .font(.system(size: 18, weight: Font.Weight.bold, design: Font.Design.default))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 12)
                Text("If you feel any of the symptoms or feeling sick, please call the free number by clicking on the call button below")
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            HStack {
                Button(action: button1Action, label: {
                    HStack {
                        Image(systemName: "heart.text.square")
                        Text("Symptoms")
                    }
                }).buttonStyle(FlatButtonStyle(color: Color.lightPurple))
                Button(action: button2Action, label: {
                    HStack {
                        Image(systemName: "hand.raised")
                        Text("Stop Covid-19")
                    }
                }).buttonStyle(FlatButtonStyle(color: Color.beige, textColor: Color.brown))
            }.padding(.top, 12)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.mainPurple))
        
    }
}

struct HeaderSection_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSection { () -> () in
            print("hello World")
        } button2Action: { () -> () in
            print("goodbye world")
        }

    }
}
