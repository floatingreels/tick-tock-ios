//
//  NavigatableListItem.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct NavigatableListItem<Label: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private let action: () -> Void
    private let label: () -> Label
    
    init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                label()
                Spacer()
                NavigationLink.empty
                    .layoutPriority(-1) // prioritize `label`
            }
        }
        .listRowBackground(Color.backgroundSecondary)
        .tint(colorScheme == .dark ? .backgroundPrimary : .black)
    }
}

#Preview {
    NavigatableListItem(action: { print() }) {
        Text("Cell text here")
    }
}
