//
//  WelcomeScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            Color(.backgroundPrimary)
                .ignoresSafeArea()
            HStack {
                Spacer()
                Button {
                    coordinator.push(.register)
                }  label: {
                    Label(
                        Translation.Startup.buttonRegister.val,
                        systemImage: "person.crop.circle.badge.plus"
                    )
                }
                Spacer()
                Button {
                    coordinator.push(.login)
                } label: {
                    Label(
                        Translation.Startup.buttonLogin.val,
                        systemImage: "person.crop.circle"
                    )
                }
                Spacer()
            }
            .padding(Spacing.interItem)
        }
    }
}

#Preview {
    WelcomeScreen()
}
