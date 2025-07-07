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
    
    static func superLargeTitle(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 56, weight: weight)
    }
    
    static func extraLargeTitle(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 36, weight: weight)
    }
    
    static func largeTitle(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 34, weight: weight)
    }
    
    static func title2(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 22, weight: weight)
    }
    
    static func title3(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 20, weight: weight)
    }
    
    static func body(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 17, weight: weight)
    }
    
    static func footnote(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 13, weight: weight)
    }
    
    static func caption(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 12, weight: weight)
    }
    
    static func caption2(weight: Font.Weight = .regular) -> Font {
        return .appFont(ofSize: 11, weight: weight)
    }
}
