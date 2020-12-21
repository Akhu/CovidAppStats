//
//  Statistic.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 26/09/2020.
//

import Foundation

public class GlobalStatistics {
    public var weeklyTrends: Double?
    public var monthlyTrend : Double?
    public var currentMonthEvolutionRate: Double?
    public var currentWeekEvolutionRate: Double?
    public let days: [DailyStatistic]
    
    public init(days: [DailyStatistic]?) {
        if let dailyStats = days {
            self.days = dailyStats
        }else {
            self.days = []
        }
        
    }
    
    
    func computeTrends() {
        
        guard self.days.count > 14 else { return }
        print(self.days[self.days.count - 1])
        
        //7 Days trends
        let previousWeek = Double((self.days[self.days.count - 14].confirmed!) - (self.days[self.days.count - 7].confirmed!))/Double(self.days[self.days.count - 7].confirmed!)
        let currentWeek = Double((self.days[self.days.count - 1].confirmed!) - (self.days[self.days.count - 7].confirmed!))/Double(self.days[self.days.count - 7].confirmed!)
        let trends = currentWeek-previousWeek
        if trends > 0 {
            print("increasing cases rate by \(trends)pts")
            
        } else {
            print("decreasing cases rate by \(trends)pts")
        }
        
        self.weeklyTrends = trends
        self.currentWeekEvolutionRate = currentWeek
        
        guard self.days.count >= 60 else { return }
        
        //30 Days trends
        let previousMonth = Double((self.days[self.days.count - 30].confirmed!) - (self.days[self.days.count - 60].confirmed!))/Double(self.days[self.days.count - 60].confirmed!)
        print(String(format: "PreviousMonth: %.4f", previousMonth))
        let currentMonth:Double = Double((self.days[self.days.count - 1].confirmed!) - (self.days[self.days.count - 30].confirmed!))/Double(self.days[self.days.count - 30].confirmed!)
        print(String(format: "CurrentMonth: %.4f", currentMonth))
        
        let monthlyTrend = currentMonth-previousMonth
        if monthlyTrend > 0 {
            print("increasing cases rate by \(monthlyTrend)pts this month compared to previous month")
        } else {
            print("decreasing cases rate by \(monthlyTrend)pts this month compared to previous month")
        }
        
        self.currentMonthEvolutionRate = currentMonth
        self.monthlyTrend = monthlyTrend
    }

}

public struct DailyStatistic: Codable {
    let country, countryCode, province, city: String?
    let cityCode, lat, lon: String?
    let confirmed, deaths, recovered, active: Int?
    let date: Date?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}
struct WorldStatLive: Codable {
    let totalConfirmed, totalDeaths, totalRecovered: Double?
    
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
}

