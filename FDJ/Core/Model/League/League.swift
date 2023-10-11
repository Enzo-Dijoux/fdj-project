//
//  League.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class League {
    let id: String
    let name: String
    let sport: String
    let alternate: String
    
    init(id: String = "", name: String = "", sport: String = "", alternate: String = "") {
        self.id = id
        self.name = name
        self.sport = sport
        self.alternate = alternate
    }
}
