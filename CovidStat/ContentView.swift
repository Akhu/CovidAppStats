//
//  ContentView.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 12/07/2020.
//

import SwiftUI
import SwiftUICharts

let apiKey = "98Z3W4KI77QTZR90"

// MAP https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui

struct ContentView: View {
    @State var countrySelectionOpen = false
    @State var selectedCountry: Country? = nil

    var body: some View {
        NavigationView {
            VStack {
                //Header
                VStack {
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            HStack {
                                Image(systemName: "phone")
                                Text("Call for help")
                            }
                            
                        }).buttonStyle(FlatButtonStyle())
                        Button(action: {
                            
                        }, label: {
                            Text("Call for help")
                        }).buttonStyle(OutlineButtonStyle())
                    }
                }
                
                Text("Error: \(selectedCountry?.emoji ?? "")")
                
                
                
                MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
                    
                        
                    
            }
            .navigationTitle("Covid Stats")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        countrySelectionOpen.toggle()
                                    }) {
                                        
                                        Text(selectedCountry?.emoji ?? "🌍") + Text(" ") +
                                        Text(selectedCountry?.name.capitalized ?? "Worldwide")
                                                .font(.callout)
                                    
                                    }.sheet(isPresented: $countrySelectionOpen) {
                                        CountrySelectionView(countrySelectionOpen: $countrySelectionOpen, selectedCountry: $selectedCountry)
                                            .padding()
                                    }
                            )
        }
        //Text("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
