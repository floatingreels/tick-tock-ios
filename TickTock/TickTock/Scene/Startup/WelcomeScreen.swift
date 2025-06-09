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
        VStack(spacing: Spacing.interItem * 3) {
            VStack(spacing: Spacing.interItem) {
                headerImage
                headerText
            }
            HStack {
                Spacer()
                registerButton
                Spacer()
                loginButton
                Spacer()
            }
            .padding(Spacing.interItem)
        }
    }
}

private extension WelcomeScreen {
    var headerImage: some View {
        Image(ResImages.App.logo.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: Size.headerImage * 3 / 2, height: Size.headerImage * 3 / 2)
    }
    var headerText: some View {
        Text(Bundle.main.bundleName)
            .foregroundStyle(Color(Color.labelLinks))
    }
    var registerButton: some View {
        Button {
            coordinator.push(.register)
        }  label: {
            Label(
                Translation.Startup.buttonRegister.val,
                systemImage: "person.crop.circle.badge.plus"
            )
        }
    }
    
    var loginButton: some View {
        Button {
            coordinator.push(.login)
        } label: {
            Label(
                Translation.Startup.buttonLogin.val,
                systemImage: "person.crop.circle"
            )
        }
    }
}

#Preview {
    WelcomeScreen()
}
