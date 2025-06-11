//
//  Alertinator.swift
//  TickTock
//
//  Created by David Gunzburg on 09/06/2025.
//

import SwiftUI

class Alertinator: ObservableObject {
    
    @Published var alert: CustomAlert?
    
    func presentAlert(_ alert: CustomAlert) {
        self.alert = alert
    }
    func dismissAlert() {
        self.alert = nil
    }
}
