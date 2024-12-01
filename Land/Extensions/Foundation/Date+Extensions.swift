//
//  Date+Extensions.swift
//  Land
//
//  Created by Luka Vujnovac on 01.12.2024..
//

import Foundation

extension Date {
    func toLongDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    func timeAgo() -> String {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.second, .minute, .hour, .day, .weekOfYear, .month, .year],
            from: self,
            to: now
        )
        
        if let years = components.year, years > 0 {
            return "\(years) year\(years > 1 ? "s" : "") ago"
        }
        if let months = components.month, months > 0 {
            return "\(months) month\(months > 1 ? "s" : "") ago"
        }
        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks) week\(weeks > 1 ? "s" : "") ago"
        }
        if let days = components.day, days > 0 {
            return "\(days) day\(days > 1 ? "s" : "") ago"
        }
        if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        }
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
        }
        if let seconds = components.second, seconds > 0 {
            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
        }
        return "just now"
    }
}
