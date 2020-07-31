//
//  CountrySelectionRow.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 31/07/2020.
//

import SwiftUI

struct CountrySelectionRow: View {
    
    var country: Country
    
    var body: some View {
        HStack {
            HStack {
                Text(country.ISO2)
                Text(country.emoji)
            }
            .frame(width: 60)
            Text(country.name)
        }
    }
}

struct CountrySelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CountrySelectionRow(country:  Country(name: "France", ISO2: "FR", emoji: "🇫🇷"))
    }
}
