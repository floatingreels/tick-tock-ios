//
//  SuccessScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 03/06/2025.
//

import SwiftUI

struct GenericSuccessData: Hashable {
    let message: String
}

struct GenericSuccessScreen: View {
    private let data: GenericSuccessData

    init(data: GenericSuccessData) {
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            headerImage
            headerText
        }
    }
}

private extension GenericSuccessScreen {
    
    var headerImage: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .frame(width: Size.headerImage, height: Size.headerImage)
    }
    
    var headerText: some View {
        Text(data.message)
    }
}

#Preview {
    GenericSuccessScreen(data: GenericSuccessData(message: "Well done. You are successful"))
}
