//
//  CovidStatsFetch.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 26/09/2020.
//

import Foundation
import Combine

enum CaseStatus: String {
    case CONFIRMED
    case DEATHS
    case RECOVERED
}

class StatisticsOverTime : ObservableObject {
    
    @Published var stats = [GlobalStatLive]()
    @Published var error : Error? = nil
    
    @Published var lastUpdate : Date? = nil
    
    var cancellable : Set<AnyCancellable> = Set()
    
    func fetchCovidStatByCountryForTimeRange(status: CaseStatus, timeRangeInDay : Int, country: Country?) {
        
        let dateTo = Date()
        let dateFrom = dateTo.currentDateLessDays(daysToRemove: 30)
        
        if let unWrappedCountry = country {
            
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.covid19api.com"
            urlComponents.path = "/total/country/\(unWrappedCountry.ISO2)"
            ///status/\(status.rawValue.lowercased())
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
                .decode(type: [GlobalStatLive].self, decoder: jsonDecoder)
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
                    self.stats = statData
                    self.lastUpdate = Date()
                })
                .store(in: &cancellable)
        }
        else {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.covid19api.com"
            urlComponents.path = "/world/total"
            
            /*urlComponents.queryItems = [
             URLQueryItem(name: "from", value: ISO8601DateFormatter().string(from: dateFrom)),
             URLQueryItem(name: "to", value: ISO8601DateFormatter().string(from: dateTo))
             ]*/
            
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
                .decode(type: WorldStatLive.self, decoder: jsonDecoder)
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
                }, receiveValue: { worldStat in
                    self.lastUpdate = Date()
                    self.stats = [GlobalStatLive(country: "World", countryCode: nil, province: nil, city: nil, cityCode: nil, lat: nil, lon: nil, confirmed: worldStat.totalConfirmed, deaths: worldStat.totalDeaths, recovered: worldStat.totalRecovered, active: nil, date: nil)]
                })
                .store(in: &cancellable)
        }
    }
    
}

