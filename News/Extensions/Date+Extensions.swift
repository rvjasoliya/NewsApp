//
//  Date+Extensions.swift
//  FuelPrice
//
//  Created by iMac on 11/11/22.
//

import Foundation

extension Date {
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func day() -> Int {
        return Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    
    func month() -> Int {
        return Calendar.current.dateComponents([.month], from: self).month ?? 0
    }
    
    func year() -> Int {
        return Calendar.current.dateComponents([.year], from: self).year ?? 0
    }
    
}
