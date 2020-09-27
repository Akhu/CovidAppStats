//
//  CovidStatApp.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 12/07/2020.
//

import SwiftUI

@main
struct CovidStatApp: App {
    var body: some Scene {
        WindowGroup {
            Dashboard(stats: StatisticsOverTime())
        }
    }
}
