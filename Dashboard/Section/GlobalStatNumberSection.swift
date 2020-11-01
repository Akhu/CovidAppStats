//
//  NumberSection.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 07/10/2020.
//

import SwiftUI

struct GlobalStatNumberSection: View {
    var deaths: Double?
    var cases: Double?
    var recoveries: Double?
    
    
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
    @State static var deaths = 12000394.0
    @State static var cases = 2947918742.0
    @State static var recoveries = 294802032.0
    
    static var previews: some View {
        GlobalStatNumberSection(deaths: deaths, cases: cases, recoveries: recoveries)
            .padding(8)
    }
}
