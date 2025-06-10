//
//  Binding+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 10/06/2025.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init(get: {
            return value.wrappedValue != nil
        }, set: { newValue in
            if !newValue {
                value.wrappedValue =  nil
            }
        })
    }
}
