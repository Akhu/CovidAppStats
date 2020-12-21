//
//  TitleDescriptionAction.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 17/11/2020.
//

import SwiftUI

struct TitleDescriptionAction: View {
    var action: () -> ()
    var description: String
    var title: String
    var icon: Image
    var buttonIcon: Image
    var buttonText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                icon
                Text(title)
                    .font(.headline)
            }.padding(.bottom, 8)
            Text(description)
                .padding(.bottom, 10)
            Button(action: action, label: {
                HStack{
                    buttonIcon
                    Text(buttonText)
                }
            }).buttonStyle(FlatButtonStyle(color: Color.mainPurple))
        }
    }
}

struct TitleDescriptionAction_Previews: PreviewProvider {
    static var previews: some View {
        TitleDescriptionAction(action: {}, description: "Fake news and myth can be dangerous too, try to keep you informed from trusted sources. Don't hesitate to mix sources and informations.", title: "Fighting fake news and myth", icon: Image(systemName: "ear.trianglebadge.exclamationmark"), buttonIcon: Image(systemName: "ear.badge.checkmark"), buttonText: "Myth busting about COVID-19")
    }
}
