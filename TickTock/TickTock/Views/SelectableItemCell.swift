//
//  SelectableItemCell.swift
//  TickTock
//
//  Created by David Gunzburg on 16/06/2025.
//

import SwiftUI

struct SelectableItemCell<Item: Selectable>: View {
    
    let item: Item
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Text(item.name)
            Spacer()
        }
        .listRowBackground(Color.backgroundCell)
        .tint(.labelPrimary)
        .modifier(CheckmarkModifier(checked: isSelected))
    }
}


#Preview {
    SelectableItemCell(
        item: Client(id: 2, name: "Some client", projects: nil, userId: 1),
        isSelected: true)
}
