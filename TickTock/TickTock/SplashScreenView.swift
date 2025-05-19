//
//  ContentView.swift
//  TickTock
//
//  Created by David Gunzburg on 16/05/2025.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color(.backgroundPrimary)
            VStack(spacing: Spacing.interItem) {
                Image(ResImages.App.logo.rawValue)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal, alignment: .center) { size, axis in
                        size / 3
                    }
                Text(Bundle.main.bundleName)
                    .font(Font.body(weight: .black))
                    .foregroundStyle(Color.labelPrimary)
            }
            .padding()
        }
        .background(Color.backgroundPrimary)
    }
}

#Preview {
    SplashScreenView()
}
