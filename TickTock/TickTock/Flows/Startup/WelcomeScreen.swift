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
                    coordinator.push(.login)
                } label: {
                    Label(
                        Translation.Startup.buttonLogin.val,
                        systemImage: "person.badge.shield.checkmark"
                    )
                }
                Spacer()
                Button {
                    coordinator.push(.register)
                }  label: {
                    Label(
                        Translation.Startup.buttonRegister.val,
                        systemImage: "person.fill.badge.plus"
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
