//
//  Date.swift
//  Miaujuda
//
//  Created by Caroline Taus on 16/12/21.
//

import Foundation

struct DateFormat {
    public func formatDate(ISODate: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        let dateLangFormatter = DateFormatter()
        let dateString: String
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        

        if let realDate = isoDateFormatter.date(from: ISODate) {
            dateLangFormatter.locale = Locale(identifier: "pt-br")
            dateLangFormatter.dateStyle = .long
            dateString = dateLangFormatter.string(from: realDate)
            return dateString
        }
        return ""
    }
}
