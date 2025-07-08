//
//  DateTimeUtil.shared.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

final class DateTimeUtil {
    
    static let shared = DateTimeUtil()
    
    private lazy var isoFormatter = ISO8601DateFormatter()
    private lazy var sessionDateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        return formatter
    }()
    private lazy var sessionDurationFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter
    }()
    
    private init() {}
    
    func formattedStringFromDate(_ date: Date) -> String {
        if date.get(.year) == Date().get(.year) {
            sessionDateFormatter.dateFormat = "MMMM d"
        } else {
            sessionDateFormatter.dateFormat = "MMMM d, yyyy"
        }
        return sessionDateFormatter.string(from: date)
    }
    
    func dateFromISOString(_ string: String) -> Date? {
        return isoFormatter.date(from: string)
    }
    
    func isoStringFromDate(_ date: Date) -> String {
        return isoFormatter.string(from: date)
    }
    
    func stopwatchStringFromInterval(_ timeInterval: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: timeInterval)
    }
    
    func formattedDurationFromISO(start: String, end: String) -> String? {
        guard let startDate = dateFromISOString(start),
              let endDate = dateFromISOString(end)
        else { return nil }
        let duration = endDate.timeIntervalSince(startDate)
        return sessionDurationFormatter.string(from: duration)
    }
}
