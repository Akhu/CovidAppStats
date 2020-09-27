//
//  Countries.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/07/2020.
//

import Foundation

enum IOError: LocalizedError {
    case fileNotFound
}


func loadAllLocale() -> [Country] {
    let list:[Country] = Locale.availableIdentifiers.compactMap { identifier in
        let local = Locale(identifier: identifier)
        print(identifier)
        if let regionCode = local.regionCode,
           let emoji = emojiFlag(regionCode: regionCode),
           let nameInCurrentLocale = Locale.current.localizedString(forRegionCode: regionCode) {
            return Country(name: nameInCurrentLocale, ISO2: regionCode, emoji: emoji)
        }
        return nil
    }
    
    return Set<Country>(list).sorted { $0.ISO2 < $1.ISO2 }
}

func emojiFlag(regionCode: String) -> String? {
    let code = regionCode.uppercased()
    guard Locale.isoRegionCodes.contains(code) else {
        return nil
    }

    var flagString = ""
    for s in code.unicodeScalars {
        guard let scalar = UnicodeScalar(127397 + s.value) else {
            continue
        }
        flagString.append(String(scalar))
    }
    return flagString
}
