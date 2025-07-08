//
//  NavigatableList.swift
//  TickTock
//
//  Created by David Gunzburg on 17/06/2025.
//

import SwiftUI

struct NavigatableList<Item: Selectable>: View {
    
    private let items: [Item]
    private let onSelection: (Int) -> Void
    
    init(items: [Item], onSelection: @escaping (Int) -> Void) {
        self.items = items
        self.onSelection = onSelection
    }
    
    var body: some View {
        List(items) { item in
            buildCell(for: item)
        }
        .contentMargins(.horizontal, CGFloat.leastNormalMagnitude)
        .contentMargins(.vertical, 0)
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .padding(isPreview ? Spacing.interItem : 0)
    }
    
    private func buildCell(for item: Item) -> some View {
        return NavigatableListCell(
            item: item,
            action: { onSelection(item.id) }
        )
    }
}


#Preview {
    NavigatableList(
        items: SessionStore.buildTestSessions().asSelectable(),
        onSelection: { id in print("Item with id: \(id)") }
    )
}
