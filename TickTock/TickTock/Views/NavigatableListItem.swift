//
//  NavigatableListItem.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct NavigatableListItem<Content: View>: View {
    
    private let action: () -> Void
    private let content: () -> Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                content()
                Spacer()
                NavigationLink.empty
                    .layoutPriority(-1)
            }
        }
        .listRowBackground(Color.backgroundCell)
        .tint(.labelPrimary)
    }
}

#Preview {
    NavigatableListItem(action: { print() }) {
        Text("Cell text here")
    }
}
