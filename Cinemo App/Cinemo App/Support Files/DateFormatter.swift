//
//  DateFormatter.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

class DateFormatterUtility {

    private static let internalFormatter: Foundation.DateFormatter = {
        let formatter = Foundation.DateFormatter()
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) as Calendar?
        formatter.locale = Locale(identifier: "en_US")
        formatter.amSymbol = ""
        formatter.pmSymbol = ""
        return formatter
    }()

    static func convert(string: String, from serverDateFormat: String, to showDateFormat: String, timeZone: TimeZoneDate) -> String {
        internalFormatter.timeZone = TimeZone(abbreviation: timeZone.rawValue)
        internalFormatter.dateFormat = serverDateFormat
        guard let date = internalFormatter.date(from: string) else { return "" }
        return format(date: date, format: showDateFormat, sendServiceFormat: timeZone == .utc)
    }

    static func format(date: Date, format: String, sendServiceFormat: Bool = false) -> String {
        internalFormatter.timeZone = sendServiceFormat ? TimeZone(abbreviation: TimeZoneDate.utc.rawValue) : .current
        internalFormatter.dateFormat = format
        return internalFormatter.string(from: date)
    }
}

// MARK: - TimeZoneDate

enum TimeZoneDate: String {
    case utc = "UTC"
    case edt = "EDT"
}
