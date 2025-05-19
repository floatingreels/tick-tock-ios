//
//  Image+Assets.swift
//  TickTock
//
//  Created by David Gunzburg on 19/05/2025.
//

import Foundation
import SwiftUICore

enum ResImages {
    
}

extension ResImages {
    
    enum App: String {
        case icon = "AppIcon"
        case logo = "Logo"
        
        var image: Image {
            return Image(self.rawValue)
        }
    }
}
