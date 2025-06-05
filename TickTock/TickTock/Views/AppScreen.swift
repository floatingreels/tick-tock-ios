//
//  AppScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 04/06/2025.
//

import Foundation

enum AppScreen: Hashable, Identifiable {
    case welcome
    case register
    case login
    case home
    case addClient
    case listClients
    case success(GenericSuccessData)
    
    var id: String { String(describing: self) }
    
    var hidesBackButton: Bool {
        switch self {
        case .home, .success: true
        default: false
        }
    }
    
    var hasLargeTitles: Bool {
        return self == .home
    }
}
