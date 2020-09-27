//
//  DateHelper.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 27/09/2020.
//

import Foundation


extension Date {
    func currentDateLessDays(daysToRemove: Int) -> Date {
        let dateComponentDay = DateComponents(day: -daysToRemove)
        let dateLessDays = Calendar.current.date(byAdding: dateComponentDay, to: self)!
        return dateLessDays
    }
    
    func dateAndHourToDisplayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
