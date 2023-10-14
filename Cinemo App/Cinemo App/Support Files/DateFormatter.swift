//
//  DateFormatter.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Foundation

// MARK: - DateFormatterUtility

class DateFormatterUtility {

    // MARK: Internal

    static func convert(
        string: String,
        from serverDateFormat: String,
        to showDateFormat: String,
        timeZone: Constants.TimeZoneDate)
        -> String
    {
        let regexPattern = " 00:00:00$"
        self.internalFormatter.timeZone = TimeZone(abbreviation: timeZone.rawValue)
        self.internalFormatter.dateFormat = serverDateFormat
        if let regex = try? NSRegularExpression(pattern: regexPattern) {
            let range = NSRange(location: 0, length: string.utf16.count)
            let modifiedString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "")
            guard let date = internalFormatter.date(from: modifiedString) else { return "" }
            return self.format(date: date, format: showDateFormat, sendServiceFormat: timeZone == .utc)
        } else {
            return ""
        }
    }

    static func format(date: Date, format: String, sendServiceFormat: Bool = false) -> String {
        self.internalFormatter.timeZone = sendServiceFormat
            ? TimeZone(abbreviation: Constants.TimeZoneDate.utc.rawValue)
            : .current
        self.internalFormatter.dateFormat = format
        return self.internalFormatter.string(from: date)
    }

    // MARK: Private

    private static let internalFormatter: Foundation.DateFormatter = {
        let formatter = Foundation.DateFormatter()
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) as Calendar?
        formatter.locale = Locale(identifier: "en_US")
        formatter.amSymbol = ""
        formatter.pmSymbol = ""
        return formatter
    }()

}

// MARK: - TimeZoneDate

extension Constants {
    enum TimeZoneDate: String {
        case utc = "UTC"
        case edt = "EDT"
    }

    enum DateFormat {
        static let serverDateFormat = "YYYY-mm-dd"
        static let showDateFormat = "MMMM dd YYYY"
    }
}



