//
//  Bundle.swift
//  TickTock
//
//  Created by David Gunzburg on 19/05/2025.
//

import Foundation

extension Bundle {
    
    var bundleName: String {
        let key = "CFBundleName"
        guard self == Bundle.main else { return key }
        return object(forInfoDictionaryKey: key) as! String
    }
}
