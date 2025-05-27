//
//  BackendCredentials.swift
//  TickTock
//
//  Created by David Gunzburg on 26/05/2025.
//

import Foundation

final class BackendCredentials {
    
    static let shared = BackendCredentials()
    private let defaults = UserDefaults.standard
    
    
    private let accessTokenKey = "accessTokenKey"
    private let refreshTokenKey = "accessTokenKey"
    
    private init() {}
    
    func setAccessToken(_ accessToken: String) {
        defaults.set(accessToken, forKey: accessTokenKey)
    }
    
    func setRefreshToken(_ refreshToken: String) {
        defaults.set(refreshToken, forKey: refreshToken)
    }
    
    func getAccessToken() -> String? {
        guard let access = defaults.string(forKey: accessTokenKey),
              !access.isEmpty
        else { return nil }
        return access
    }
    
    func getRefreshToken() -> String? {
        guard let refresh = defaults.string(forKey: refreshTokenKey),
              !refresh.isEmpty
        else { return nil }
        return refresh
    }
}
