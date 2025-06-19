//
//  JustifiedHStack.swift
//  TickTock
//
//  Created by David Gunzburg on 18/06/2025.
//

import SwiftUI

struct CenteredHStack<Content: View>: View {
    
    private var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        HStack {
            Spacer()
            content()
            Spacer()
        }
    }
}
