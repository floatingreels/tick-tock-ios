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
    }
    
    private func buildCell(for item: Item) -> some View {
        return NavigatableListCell(
            action: {
                onSelection(item.id)
            },
            content: {
                Text(item.name)
            })
    }
}


#Preview {
    NavigatableList(
        items: [
            Client(id: 1, name: "Client 1", projects: [], userId: 0),
            Client(id: 2, name: "Client 2", projects: [], userId: 0),
            Client(id: 3, name: "Client 3", projects: [], userId: 0),
            Client(id: 4, name: "Client 4", projects: [], userId: 0)
        ],
         onSelection: { id in print("Item with id: \(id)") }
    )
}
