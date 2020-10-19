//
//  ContentView.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 12/07/2020.
//

import SwiftUI
import SwiftUICharts

let apiKey = "98Z3W4KI77QTZR90"

enum TimeRange: Identifiable, CaseIterable {
    public var id : TimeRange { self }
    
    case week,month,allTime
}

// MAP https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui

struct Dashboard: View {
    @State var countrySelectionOpen = false
    @State var selectedCountry: Country? = nil
    @ObservedObject var stats: StatisticsOverTime
    @State var timeRangeSelection : TimeRange = .week

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    HeaderSection { () -> () in
                        print("hello")
                    } button2Action: { () -> () in
                        stats.fetchCovidStatByCountryForTimeRange(status: .CONFIRMED, timeRangeInDay: 30, country: selectedCountry)
                    }
                    
                    Divider()
                        .padding(.vertical, 12.0)
                        
                    Picker(selection: $timeRangeSelection, label: Text("Picker"))/*@START_MENU_TOKEN@*/{
                        ForEach(TimeRange.allCases) { timeRange in
                            Text("\(String(describing: timeRange).capitalized)").tag(timeRange)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("Last update: \(stats.lastUpdate?.dateAndHourToDisplayFormat() ?? "Never")")
                        .font(.system(size: 10, weight: Font.Weight.regular, design: .default))
                        .foregroundColor(.gray)
                    
                    GlobalStatNumberSection(deaths: 1200, cases: 2040200, recoveries: 25004).frame(height: 270)
                    
                    //Text("debug: \(String(describing: stats.stats.count))")
                    //Text("Error: \(String(describing: stats.error))")
                    //Text("Range: \(String(describing: timeRangeSelection))")
                    
                    TipImage()
                    
                    
                    
                }.padding()
            }
            .navigationTitle("Covid Stats")
            .navigationBarItems(trailing:
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
                            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(stats: StatisticsOverTime())
//        VStack {
//            MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
//        }
    }
}
