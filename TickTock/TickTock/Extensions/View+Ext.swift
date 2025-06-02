//
//  View+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 28/05/2025.
//

import SwiftUI

extension View {
    
    var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
