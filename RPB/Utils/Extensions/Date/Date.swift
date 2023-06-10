//
//  Date.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import Foundation
import UIKit

extension Date {
    
    func is10Plus() -> Bool {
        let dateOfBirth = self
        let today = Date()
        guard let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {return false}
        
        let age = gregorian.components(.year, from: dateOfBirth, to: today)
        if let year = age.year, year < 10 {
            return false
        }
        
        return true
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func toLocalTime() -> Date {
        let timeZone = TimeZone.current
        let secondsFromGMT = timeZone.secondsFromGMT()
        return Date(timeInterval: TimeInterval(secondsFromGMT), since: self)
    }
    
    func getEventListingDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy - hh:mm a"
        return formatter.string(from: self)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
            return calendar.dateComponents(Set(components), from: self)
        }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func toUTC() -> String {
        let format = DateFormatter.init()
        format.dateFormat = DateFormat.dateFormatyyyMMddTZHHmmss
        format.timeZone = TimeZone.init(identifier: "UTC")
        let str = format.string(from: self)
        return str
    }
}
