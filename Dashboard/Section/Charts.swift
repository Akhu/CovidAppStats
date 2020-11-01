//
//  Charts.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/10/2020.
//

import SwiftUI
import SwiftUICharts

struct Charts: View {
    let customStyle = ChartStyle(backgroundColor: Color.blue, accentColor: Color.customPurple, gradientColor: GradientColors.green, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.purple )
    var body: some View {
        VStack {
            GeometryReader { geo in
                BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550),("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550), ("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550), ("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly", style: customStyle, form: ChartForm.extraLarge, dropShadow: false)
                    .frame(width: geo.size.width, height: 500)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.blue.opacity(0.2))
                    ).frame(width: geo.size.width, height: geo.size.height)
            }
        }.padding()
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        Charts()
    }
}
