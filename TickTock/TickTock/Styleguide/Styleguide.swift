//
//  Styleguide.swift
//  TickTock
//
//  Created by David Gunzburg on 19/05/2025.
//

import Foundation

typealias StringAttributes = [NSAttributedString.Key: Any]

final class Spacing {
    static let interItem: CGFloat = 16
}

final class Size {
    static let cornerRadius: CGFloat = 12
    static let detailHeaderLogo: CGFloat = 64
    static let listItemInnerImage: CGFloat = 24
    static let listItemOuterImage: CGFloat = 40
}

final class Height {
    static let actionButton: CGFloat = 48
    static let estimatedTextInputField: CGFloat = 52
    static let imageHeader: CGFloat = 240
    static let progressBar: CGFloat = 8
    static let segmentedControl: CGFloat = 34
    static let separator: CGFloat = 1
}
