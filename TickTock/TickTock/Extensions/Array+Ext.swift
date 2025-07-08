//
//  Array+Ext.swift
//  TickTock
//
//  Created by David Gunzburg on 08/07/2025.
//

extension Array where Element == Client {
    
    func asSelectable() -> [ClientCellData] {
        return self.compactMap { $0.toSelectable() }
    }
}

extension Array where Element == Project {
    
    func asSelectable() -> [ProjectCellData] {
        return self.compactMap { $0.toSelectable() }
    }
}

extension Array where Element == Session {
    
    func asSelectable() -> [SessionCellData] {
        return self.compactMap { $0.toSelectable() }
    }
}
