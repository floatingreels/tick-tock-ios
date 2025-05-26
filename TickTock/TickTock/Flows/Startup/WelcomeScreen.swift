//
//  WelcomeScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        ZStack {
            Color(.backgroundPrimary)
                .ignoresSafeArea()
            HStack {
                Spacer()
                NavigationLink {
                    LoginScreen()
                } label: {
                    Label(
                        Translation.Startup.buttonLogin.val,
                        systemImage: "person.badge.shield.checkmark"
                    )
                }
                Spacer()
                NavigationLink {
                    RegisterScreen()
                } label: {
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
