//
//  APICaller.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/07/2020.
//

import Foundation
import Combine
let countryListUrl = URL(string: "https://api.covid19api.com/countries")!



class Countries : ObservableObject{
    
    @Published var countryList = [Country]()
    @Published var error : Error? = nil
    @Published var currentPrice = "...."
    var urlBase = "https://api.covid19api.com/countries"
    
    var cancellable : Set<AnyCancellable> = Set()
    
    init(_ fromFile: Bool = false) {
        if fromFile {
            if let countries = try? mockLoadCountries() {
                countryList = countries
            }
        } else {
            fetchCountryList()
        }
    }
    
    func fetchCountryList() {
        
        URLSession.shared.dataTaskPublisher(for: countryListUrl)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("invalid status")
                    throw NSError()
                }
                print(String(data: data, encoding: .utf8))
                return data
            }
            .decode(type: [Country].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let catchedError):
                    self.error = catchedError
                    break
                case .finished:
                    self.error = nil
                    break
                }
            }, receiveValue: { countriesData in
                self.countryList = countriesData.sorted { $0.name < $1.name }
            })
            .store(in: &cancellable)
    }
}
