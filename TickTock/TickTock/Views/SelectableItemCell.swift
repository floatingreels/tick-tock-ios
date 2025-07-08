//
//  SelectableItemCell.swift
//  TickTock
//
//  Created by David Gunzburg on 16/06/2025.
//

import SwiftUI
 
struct SelectableItemCell<Item: Selectable>: View {
    
    private let item: Item
    private let isSelected: Bool
    
    init(item: Item, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(item.title)
                .font(Font.body())
            Spacer()
        }
        .listRowBackground(getCellBackgroundColor())
        .tint(.labelPrimary)
        .modifier(CheckmarkModifier(checked: isSelected))
    }       
    
    func getCellBackgroundColor() -> Color {
        if isPreview {
            isSelected ? Color.backgroundSecondary : Color.backgroundPrimary
        } else {
            isSelected ? Color.backgroundPrimary : Color.backgroundCell
        }
    }
}


#Preview {
    SelectableItemCell(
        item: SessionStore.buildTestSessions().randomElement()!.toSelectable(),
        isSelected: true
    )
}
