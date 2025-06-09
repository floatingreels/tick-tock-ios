//
//  NavigatableSheetPresenter.swift
//  TickTock
//
//  Created by David Gunzburg on 03/06/2025.
//

import SwiftUI

struct NavigatableSheetPresenter<Navigatable: View>: View {
    
    @State private var isPresenting: Bool = false
    private var navigatable: () -> Navigatable
    private var label: String?
    private var image: ImageTuple?
    private var dismissHandler: DismissHandler?
    
    init(@ViewBuilder navigatable: @escaping () -> Navigatable,
         label: String,
         dismissHandler: DismissHandler? = nil) {
        self.navigatable = navigatable
        self.label = label
        self.image = nil
        self.dismissHandler = dismissHandler
    }
    
    init(@ViewBuilder navigatable: @escaping () -> Navigatable,
         image: ImageTuple,
         dismissHandler: DismissHandler? = nil) {
        self.navigatable = navigatable
        self.label = nil
        self.image = image
        self.dismissHandler = dismissHandler
    }
    
    var body: some View {
        if let label {
            buildLabelButton(label)
                .sheet(
                    isPresented: $isPresenting,
                    onDismiss: dismissHandler
                ) {
                    navigatable()
                        .environment(\.modalMode, self.$isPresenting)
                }
        } else if let image {
            buildIconButton(image)
                .sheet(
                    isPresented: $isPresenting,
                    onDismiss: dismissHandler
                ) {
                    navigatable()
                        .environment(\.modalMode, self.$isPresenting)
                }
        }
    }
}

private extension NavigatableSheetPresenter {
    
    func buildLabelButton(_ label: String) -> some View {
        Button {
            isPresenting.toggle()
        } label: {
            Text(label)
        }
    }
    
    func buildIconButton(_ image: ImageTuple) -> some View {
        Button(action: {
            isPresenting.toggle()
        }) {
            image.isSystem ? Image(systemName: image.name) : Image(image.name)
        }
    }
}


