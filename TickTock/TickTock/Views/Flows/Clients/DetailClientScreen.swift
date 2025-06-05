//
//  ListClientsScreen 2.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

struct DetailClientScreen: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        List(clients) { client in
            Text(client.name)
        }
        .task {
            fetchClientDetails()
        }
        .navigationTitle(Translation.Client.listClientsNavTitle.val)
    }
}
