//
//  TipImage.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/10/2020.
//

import SwiftUI

struct TipImage: View {
    
    var illustration: String = "washHands"
    var title = "Wash your hands frequently"
    var icon = "hand.raised"
    var content = "Wash your hands often with soap and water for at least 20 seconds especially after you have been in a public place."
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
            }
            HStack {
                Image(illustration)
                Text(content)
                    .lineLimit(nil)
                    .font(.subheadline)
                Image(systemName: "info.circle.fill")
            
            }
        }
    }
}

struct TipImage_Previews: PreviewProvider {
    static var previews: some View {
        TipImage()
    }
}
