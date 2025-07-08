//
//  NavigatableListCell.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct NavigatableListCell<Item: Selectable>: View {
    
    private let item: Item
    private let action: () -> Void
    
    init(item: Item, action: @escaping () -> Void) {
        self.item = item
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let _ = item.subtitle {
                    HStack {
                        titleLabel
                        Spacer()
                        subtitleLabel
                    }
                } else {
                    titleLabel
                    Spacer()
                }
                chevron
            }
        }
        .listRowBackground(isPreview ? Color.backgroundPrimary : Color.backgroundCell)
        .tint(.labelPrimary)
    }
    
    var titleLabel: some View {
        Text(item.title).font(Font.body())
    }
    
    var subtitleLabel: some View {
        Text(item.subtitle ?? "").font(Font.footnote())
    }
    
    var chevron: some View {
        NavigationLink.empty
            .layoutPriority(-1)
    }
}

#Preview {
    NavigatableListCell(
        item: ProjectStore.buildTestProjects().randomElement()!.toSelectable(),
        action: { print() }
    )
}
