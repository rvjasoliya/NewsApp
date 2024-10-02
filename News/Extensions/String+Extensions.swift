//
//  String+Extensions.swift
//  News
//
//  Created by iMac on 23/01/24.
//

import Foundation
import UIKit

extension String {
    
    func setTimesAgo() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)!
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1
        formatter.calendar?.timeZone = TimeZone(abbreviation: "GMT")!
        if let timeString = formatter.string(from: date, to: Date()) {
            return "\(timeString) ago"
        }
        return self
    }
    
    func toFormatedDate(from: String, to:String) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        let date = dateFormatter.date(from: self)
        return date?.getFormattedDate(format: to)
    }
    
}
