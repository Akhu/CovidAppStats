//
//  NumberSection.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 07/10/2020.
//

import SwiftUI

struct GlobalStatNumberSection: View {
    
    let deaths: Int
    let cases: Int
    let recoveries: Int
    
    var body: some View {
        VStack {
            HStack {
                NumberCard(value: recoveries, label: "Recovery", color: Color.teal, labelColor: Color.tealShadow)
                NumberCard(value: deaths, label: "Death", color: Color.customRed, labelColor: Color.redShadow)
            }
            Spacer()
                .frame(height: 0)
            //Todo : Bigger version and that take all the space
            NumberCard(value: cases, label: "Cases", color: Color.customPurple, labelColor: Color.purpleShadow)
                
        }.frame(maxHeight: 280)
    }
}

struct GlobalStatNumberSection_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatNumberSection(deaths: 1200, cases: 2040200, recoveries: 25004)
            .padding(8)
    }
}
