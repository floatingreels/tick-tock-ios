//
//  APIErrorResponse.swift
//  TickTock
//
//  Created by David Gunzburg on 08/04/2026.
//

import Foundation

struct APIErrorResponse: Error, Respondable {
    
    var success: Bool = false
    let code: Int?
    let message: String?
    let args: [String]?
}
