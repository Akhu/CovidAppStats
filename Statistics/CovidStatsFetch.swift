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

struct WorldStat {
    let totalConfirmed: Int
    let totalDeaths : Int
    let totalRecovered : Int
}

class StatisticsOverTime : ObservableObject {
    
    @Published var fetchedStats = [GlobalStatLive]()
    @Published var worldStat = WorldStatLive(totalConfirmed: 152, totalDeaths: 561, totalRecovered: 10)
    @Published var error : Error? = nil
    @Published var isFetching : Bool = true
    
    @Published var lastUpdate : Date? = nil
    
    var cancellable : Set<AnyCancellable> = Set()
    
    func fetchCovidStatWorldAllTime() {
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
        fetch(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let catchedError):
                    print(catchedError.localizedDescription)
                    self.error = catchedError
                    break
                case .finished:
                    self.error = nil
                    break
                }
            }, receiveValue: { (worldStat: WorldStatLive) in
                self.lastUpdate = Date()
                self.worldStat = worldStat
                self.isFetching = false
            })
            .store(in: &cancellable)
    }
    
    func fetchCovidStatByCountryForTimeRange(status: CaseStatus, timeRangeInDay : Int, country: Country?) {
        
        let dateTo = Date()
        let dateFrom = dateTo.currentDateLessDays(daysToRemove: 30)
        
        guard let unWrappedCountry = country else { return }
            
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
                self.fetchedStats = statData
                self.lastUpdate = Date()
                self.isFetching = false
            })
            .store(in: &cancellable)
    
    }
    
}

