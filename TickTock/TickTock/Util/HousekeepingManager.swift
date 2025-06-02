//
//  HousekeepingManager.swift
//  TickTock
//
//  Created by David Gunzburg on 02/06/2025.
//

final class HousekeepingManager {
    
    static let shared = HousekeepingManager()
    
    func logout() {
        TickTockDefaults.shared.clearUserData()
        BackendCredentials.shared.clearTokens()
    }
}
