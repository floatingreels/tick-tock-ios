//
//  Font+Palette.swift
//  TickTock
//
//  Created by David Gunzburg on 19/05/2025.
//

import SwiftUI

extension Font {
    
    private static func appFont(ofSize fontSize: CGFloat, weight: Font.Weight = .regular) -> Font {
        let font = Font.custom("Lato-Regular", size: fontSize)
        switch weight {
        case .regular, .medium, .ultraLight, .light, .thin: return font
        case .bold, .semibold, .heavy, .black: return font.bold()
        default: return font
        }
    }
    
    static func body(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 17, weight: weight)
    }
}
