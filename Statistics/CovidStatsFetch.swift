//
//  CovidStatsFetch.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 26/09/2020.
//

import Foundation
import Combine

public enum CaseStatus: String {
    case confirmed
    case deaths
    case recovered
}

struct WorldStat {
    let totalConfirmed: Int
    let totalDeaths : Int
    let totalRecovered : Int
}

public class StatisticsOverTime : ObservableObject {
    
    public init(){}
    
    @Published var fetchedStats: GlobalStatistics?
    @Published var worldStat = WorldStatLive(totalConfirmed: 152, totalDeaths: 561, totalRecovered: 10)
    @Published var error : Error? = nil
    @Published var isFetching : Bool = true
    
    @Published var lastUpdate : Date? = nil
    
    var cancellable : Set<AnyCancellable> = Set()
    
    public func fetchCovidStatByCountry(forTimeRange timeRangeInDay: Int, andCountry country: String) {
        //This f*cking API only work if Hour, Minutes and second are set to 0...
        let dateTo = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        let dateFrom = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dateTo.currentDateLessDays(daysToRemove: timeRangeInDay))!
    
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.covid19api.com"
        urlComponents.path = "/total/country/\(country)"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "from", value: ISO8601DateFormatter().string(from: dateFrom)),
            URLQueryItem(name: "to", value: ISO8601DateFormatter().string(from: dateTo))
        ]
        
        print(urlComponents.url?.absoluteURL)
        guard let url = urlComponents.url else { return }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("invalid status")
                    throw NSError()
                }
                //print(String(data: data, encoding: .utf8))
                return data
            }
            .decode(type: [DailyStatistic].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let catchedError):
                    print(catchedError)
                    self.error = catchedError
                    break
                case .finished:
                    self.error = nil
                    break
                }
            }, receiveValue: { statData in
                let globalStatistics = GlobalStatistics(days: statData)
                globalStatistics.computeTrends()
                self.fetchedStats = globalStatistics
                self.lastUpdate = Date()
                self.isFetching = false
            })
            .store(in: &cancellable)
    }
    
    public func fetchCovidStatByCountryForTimeRange(forStatus status: CaseStatus, timeRangeInDay: Int, country: String) {
        //This f*cking API only work if Hour, Minutes and second are set to 0...
        let dateTo = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        let dateFrom = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dateTo.currentDateLessDays(daysToRemove: 30))!
    
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.covid19api.com"
        urlComponents.path = "/total/country/\(country)/status/\(status)"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "from", value: ISO8601DateFormatter().string(from: dateFrom)),
            URLQueryItem(name: "to", value: ISO8601DateFormatter().string(from: dateTo))
        ]
        
        print(urlComponents.url?.absoluteURL)
        guard let url = urlComponents.url else { return }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("invalid status")
                    throw NSError()
                }
                //print(String(data: data, encoding: .utf8))
                return data
            }
            .decode(type: [DailyStatistic].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let catchedError):
                    print(catchedError)
                    self.error = catchedError
                    break
                case .finished:
                    self.error = nil
                    break
                }
            }, receiveValue: { statData in
                //TODO : Calculate Trends https://colab.research.google.com/drive/1q9i1twdunlecC6ml_kbjl4PyCavCWQ1A
                //deductTrends(data: statData)
               // self.fetchedStats = statData
                self.lastUpdate = Date()
                self.isFetching = false
            })
            .store(in: &cancellable)
    }
}

