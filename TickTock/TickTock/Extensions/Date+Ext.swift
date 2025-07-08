//
//  Date+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 08/07/2025.
//

import Foundation

extension Date {
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
