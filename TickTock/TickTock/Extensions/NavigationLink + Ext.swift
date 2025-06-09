//
//  NavigationLink + Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 05/06/2025.
//

import SwiftUI

extension NavigationLink where Label == EmptyView, Destination == EmptyView {
    
    // A Navigation Link view with no destination (used for programmatic navigation)
   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}
