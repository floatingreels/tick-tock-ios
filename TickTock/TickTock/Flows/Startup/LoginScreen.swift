//
//  LoginView.swift
//  TickTock
//
//  Created by David Gunzburg on 20/05/2025.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Some form to fill in")
            }
        }
        .navigationTitle("Login screen")
        
        .onAppear {
            print("LoginView appeared")
        }
        .onDisappear() {
            print("LoginView disappeared")
        }
    }
}

#Preview {
    LoginScreen()
}
