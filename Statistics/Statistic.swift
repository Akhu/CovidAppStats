//
//  Statistic.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 26/09/2020.
//

import Foundation

struct GlobalStatLive: Codable {
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
    let totalConfirmed, totalDeaths, totalRecovered: Int?

    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
}
