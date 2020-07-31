//
//  CountrySelectionView.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/07/2020.
//

import SwiftUI

struct CountrySelectionView: View {
    
    @State var searchString: String = ""
    
    @Binding var countrySelectionOpen: Bool
    @Binding var selectedCountry: Country?
    
    let countries = loadAllLocale()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select a Country")
                .font(.largeTitle)
                .fontWeight(.heavy)

            SearchBarText(placeholder: "Search Country", text: $searchString)
            List {
                
                ForEach(countries.filter { term in
                    if searchString.isEmpty {
                        return true
                    }
                    return term.name.lowercased().contains(searchString.lowercased())
                }) { country in
                    CountrySelectionRow(country: country)
                        .onTapGesture {
                            selectedCountry = country
                            countrySelectionOpen.toggle()
                        }
                }
            }
        }
    }
}

struct CountrySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CountrySelectionView(countrySelectionOpen: .constant(true), selectedCountry: .constant(nil))
    }
}
