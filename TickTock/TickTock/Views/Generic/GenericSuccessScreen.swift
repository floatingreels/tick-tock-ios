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
    
    @Environment(\.modalMode) var modalMode
    private let data: GenericSuccessData

    init(data: GenericSuccessData) {
        self.data = data
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: Spacing.interItem * 3) {
                headerImage
                headerText
            }
            .containerRelativeFrame(.vertical, alignment: .center) { size, _ in
                size / 3
            }
            Spacer()
            closeButton
        }
        .padding(Spacing.interItem)
        .navigationTitle(Translation.General.successNavTitle.val)
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
    var closeButton: some View {
        Button {
            modalMode.wrappedValue = false 
        } label: {
            Text(Translation.General.buttonClose.val)
        }
    }
}

#Preview {
    GenericSuccessScreen(data: GenericSuccessData(message: "Well done. You are successful"))
}
