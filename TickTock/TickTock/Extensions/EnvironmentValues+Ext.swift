//
//  EnvironmentValues+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 07/06/2025.
//  Thanks @Asperi: https://stackoverflow.com/questions/59824443/dismiss-a-parent-modal-in-swiftui-from-a-navigationview

import SwiftUI

extension EnvironmentValues {
    var modalMode: Binding<Bool> {
        get {
            return self[ModalModeKey.self]
        }
        set {
            self[ModalModeKey.self] = newValue
        }
    }
}

struct ModalModeKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false) // < required
}
