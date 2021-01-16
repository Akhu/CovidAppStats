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
    @ObservedObject var statisticsManager: StatisticsOverTime
    @State var timeRangeSelection : TimeRange = .week
    @State var informationSheetOpen = false

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                    //Text("debug: \(String(selectedCountry?.ISO2 ?? "Caca"))")
                    //Text("Error: \(String(describing: stats.error))")
                    //Text("Range: \(String(describing: timeRangeSelection))")
                    HeaderSection(button1Action: {
                            if let country = selectedCountry {
                                self.statisticsManager.fetchCovidStatByCountry(forTimeRange: 60, andCountry: "USA")
                            } else {
                                self.statisticsManager.fetchCovidStatByCountry(forTimeRange: 60, andCountry: "USA")
                            }
                    }, button2Action: { informationSheetOpen.toggle() })
                    .sheet(isPresented: $informationSheetOpen) { InformationSheetCovid() }
                    
                    Divider()
                        .padding(.vertical, 12.0)
                    Picker(selection: $timeRangeSelection, label: Text("Picker"))/*@START_MENU_TOKEN@*/{
                        ForEach(TimeRange.allCases) { timeRange in
                            Text("\(String(describing: timeRange).capitalized)").tag(timeRange)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(selectedCountry == nil)
                    
                    Text("Last update: \(statisticsManager.lastUpdate?.dateAndHourToDisplayFormat() ?? "Never")")
                        .font(.system(size: 12, weight: Font.Weight.regular, design: .default))
                        .foregroundColor(.gray)
                    Spacer().frame(height: 24)
                    
                    if let _ = selectedCountry {
                        GlobalStatNumberSection(deaths: 20490, cases: 128570, recoveries: 29928401, deathRate: 1.2,caseRate: 1.4, recoveryRate: 4.0)
                    } else {
                        GlobalStatNumberSection(deaths: 20490, cases: 128570, recoveries: 29928401, deathRate: 1.2,caseRate: 1.4, recoveryRate: 4.0)
                    }
                    TitleDescriptionAction(action: {}, description: "Fake news and myth can be dangerous too, try to keep you informed from trusted sources. Don't hesitate to mix sources and informations.", title: "Fighting fake news and myth", icon: Image(systemName: "ear.trianglebadge.exclamationmark"), buttonIcon: Image(systemName: "ear.badge.checkmark"), buttonText: "Myth busting about COVID-19")
                }.padding()
            }
            .navigationTitle("Covid Stats")
            .navigationBarItems(trailing:
                                    TrailingNavigationBarItem(selectedCountry: $selectedCountry, countrySelectionOpen: $countrySelectionOpen)
                            )
        }
        .onAppear(perform: {
            self.statisticsManager.fetchCovidStatByCountry(forTimeRange: 60, andCountry: "USA")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(statisticsManager: StatisticsOverTime())
//        VStack {
//            MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
//        }
    }
}


