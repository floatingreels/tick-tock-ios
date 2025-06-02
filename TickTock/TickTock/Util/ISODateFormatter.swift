//
//  ISODateFormatter.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

import Foundation

final class ISODateFormatter {
    
    static let shared = ISODateFormatter()
    
    private let formatter: ISO8601DateFormatter
    
    private init() {
        self.formatter = ISO8601DateFormatter()
    }
    
    func dateFromISOString(_ string: String) -> Date? {
        return formatter.date(from: string)
    }
    
    func isoStringFromDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }
}
