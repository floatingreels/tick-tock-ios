//
//  Respondable.swift
//  TickTock
//
//  Created by David Gunzburg on 16/06/2025.
//

protocol Respondable: Codable {
    var success: Bool { get }
    var message: String? { get }
}
