//
//  InformationSheetCovid.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 17/11/2020.
//

import SwiftUI

struct InformationSheetCovid: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select a Country")
                .font(.largeTitle)
                .fontWeight(.heavy)
            AlertViewWithAction()
            ForEach(covidTipList, id: \.id) {
                Text("\($0.title)")
            }
        }
    }
}

struct InformationSheetCovid_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheetCovid()
    }
}
