//
//  Country.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 31/07/2020.
//

import Foundation
/**
 "Country": "Iceland",
 "Slug": "iceland",
 "ISO2": "IS"
 */
public struct Country: Codable {
    public var name : String
    public var ISO2 : String
    public var emoji: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case ISO2
        case emoji
    }
}

extension Country: Identifiable, Hashable {
    public var id: String {
        self.ISO2
    }
    
    
}
