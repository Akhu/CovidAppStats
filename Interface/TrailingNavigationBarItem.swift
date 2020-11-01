//
//  TrailingNavigationBar.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 01/11/2020.
//

import SwiftUI

struct TrailingNavigationBarItem: View {
    
    @Binding var selectedCountry: Country?
    @Binding var countrySelectionOpen: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                countrySelectionOpen.toggle()
            }, label: {
                withAnimation {
                    Text(selectedCountry?.emoji ?? "🌍") + Text(" ") +
                        Text(selectedCountry?.name.capitalized ?? "Worldwide")
                        .font(.callout)
                }
            })
            .transition(.scale)
            .id("countrySelected" + "\(selectedCountry?.name ?? "Worldwide")")
            .sheet(isPresented: $countrySelectionOpen) {
                CountrySelectionView(countrySelectionOpen: $countrySelectionOpen, selectedCountry: $selectedCountry)
                    .padding()
            }
        }
    }
}

struct TrailingNavigationBarItem_Previews: PreviewProvider {
    @State static var selectedCountry: Country? = nil
    @State static var isOpen: Bool = false
    
    static var previews: some View {
        TrailingNavigationBarItem(selectedCountry: $selectedCountry , countrySelectionOpen: $isOpen)
    }
}
