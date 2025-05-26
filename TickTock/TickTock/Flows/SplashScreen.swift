//
//  ContentView.swift
//  TickTock
//
//  Created by David Gunzburg on 16/05/2025.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var hasTimeElapsed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.backgroundPrimary)
                    .ignoresSafeArea()
                VStack(spacing: Spacing.interItem) {
                    Spacer()
                    Image(ResImages.App.logo.rawValue)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal, alignment: .center) { size, axis in
                            size / 3
                        }
                    Text(Bundle.main.bundleName)
                        .font(.body())
                        .foregroundStyle(.labelPrimary)
                    Spacer()
                }
                .padding(Spacing.interItem)
            }
            .navigationDestination(isPresented: $hasTimeElapsed) {
                WelcomeScreen()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            print("SplashScreenView appeared")
        }
        .onDisappear() {
            print("SplashScreenView disappeared")
        }
        .task {
            await delayNavigation()
        }
    }
    
    private func delayNavigation() async {
        try? await Task.sleep(for: .seconds(1))
        hasTimeElapsed = true
    }
}

#Preview {
    SplashScreen()
}
