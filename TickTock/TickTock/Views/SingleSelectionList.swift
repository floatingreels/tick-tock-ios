//
//  SingleSelectionList.swift
//  TickTock
//
//  Created by David Gunzburg on 12/06/2025.
//

import SwiftUI

protocol Selectable: Identifiable {
    var id: Int { get }
    var name: String { get }
}

struct SingleSelectionList<Item: Selectable>: View {
    
    var items: [Item]
    @Binding var selectedItemId: Int?
    
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
        SelectableItemCell(item: item, isSelected: item.id == selectedItemId)
            .contentShape(Rectangle())
            .onTapGesture {
                selectedItemId = item.id
            }
    }
}

#Preview  {
    @Previewable @State var selectedItemId: Int? = 1
    SingleSelectionList(
        items: [
            Client(id: 1, name: "Some client", projects: nil, userId: 1),
            Client(id: 2, name: "Another client", projects: nil, userId: 1),
            Client(id: 3, name: "Weird client", projects: nil, userId: 1)
            
        ],
        selectedItemId: $selectedItemId)
}
