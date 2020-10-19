//
//  Charts.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/10/2020.
//

import SwiftUI
import SwiftUICharts

struct Charts: View {
    let customStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color.customPurple, gradientColor: GradientColors.green, textColor: Color.black, legendTextColor: Color.red, dropShadowColor: Color.purple)
    var body: some View {
        VStack {
            LineView(data: [8.0,32,11,23,40,28], title: "Title", style: customStyle)
                
            MultiLineChartView(
                data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title",
                style: customStyle, dropShadow: false)
        }
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        Charts()
    }
}
