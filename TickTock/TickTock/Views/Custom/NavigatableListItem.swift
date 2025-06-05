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
    // Fix the `tint` color that `Button` adds
    .tint(colorScheme == .dark ? .white : .black) // TODO: Change this for your app
  }
}
