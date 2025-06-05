//
//  HeaderImageView.swift
//  TickTock
//
//  Created by David Gunzburg on 03/06/2025.
//

import SwiftUI

typealias ImageTuple = (name: String, isSystem: Bool)

struct HeaderImageView: View {
    
    private let image: ImageTuple
    
    init(image: ImageTuple) {
        self.image = image
    }
    
    var body: some View {
        return image.isSystem
            ? Image(systemName: image.name)
                .resizable()
                .scaledToFit()
                .frame(width: Size.headerImage, height: Size.headerImage)
            : Image(image.name)
                .resizable()
                .scaledToFit()
                .frame(width: Size.headerImage, height: Size.headerImage)
    }
}
