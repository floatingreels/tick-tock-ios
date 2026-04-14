//
//  Requestable.swift
//  TickTock
//
//  Created by David Gunzburg on 16/06/2025.
//

import Foundation

public enum RequestMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias RequestQuery = [String: String]

typealias RequestBody = [String: Any]

protocol Requestable {
    var relativeURL: URL? { get }
    var method: RequestMethod { get }
    var query: RequestQuery? { get }
    var body: RequestBody? { get }
}
