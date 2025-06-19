//
//  CheckmarkModifier.swift
//  TickTock
//
//  Created by David Gunzburg on 15/06/2025.
//

import SwiftUI

struct CheckmarkModifier: ViewModifier {
    var checked: Bool = false
    func body(content: Content) -> some View {
        Group {
            if checked {
                ZStack(alignment: .trailing) {
                    content
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.green)
                }
            } else {
                content
            }
        }
    }
}
