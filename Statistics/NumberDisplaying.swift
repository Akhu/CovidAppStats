//
//  NumberDisplaying.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 01/11/2020.
//

import Foundation

extension Double {
    var kmFormatted: String {
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current, self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current, self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", locale: Locale.current, self)
    }
    
    var kmFormattedDouble: Double {
        if self >= 10000, self <= 999999 {
            return self/1000
        }
        if self > 999999 {
            return self/1000000
        }
        
        return self
    }
}
