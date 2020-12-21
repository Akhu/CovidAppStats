//
//  AlertViewWithAction.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 17/11/2020.
//

import SwiftUI

struct AlertViewWithAction: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "exclamationmark.shield.fill")
                    .font(.largeTitle)
                Text("This app does not replace official guidelines, recommandations or app from your governement.")
            }
            Spacer()
                .frame(height: 18)
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "link")
                    Text("International guidelines from WHO")
                }
            }).buttonStyle(FlatButtonStyle(color: Color.beige, textColor: Color.brown))
        }.padding()
        
        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.hardRed))
        .foregroundColor(.white)
    }
}

struct AlertViewWithAction_Previews: PreviewProvider {
    static var previews: some View {
        AlertViewWithAction()
    }
}
