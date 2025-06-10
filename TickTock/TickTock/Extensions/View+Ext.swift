//
//  View+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 28/05/2025.
//

import SwiftUI

extension View {
    
    // allow variations for preview purposes
    var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    // modifier for alert presentation using CustomAlert object
    func alert(_ alertData: Binding<CustomAlert?>) -> some View {
        let alert = alertData.wrappedValue
        return self.alert(
            alert?.title ?? Translation.Error.general_title.val,
            isPresented: Binding(value: alertData),
            presenting: alert,
            actions: { alert in
                ForEach(alert.actions, id: \.id) { action in
                    Button(action.title, action: action.completion)
                }
            },
            message: { alert in
                Text(alert.message)
            })
    }
    
}
