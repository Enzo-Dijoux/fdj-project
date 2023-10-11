//
//  League.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class League: Equatable {
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
    
    static func == (lhs: League, rhs: League) -> Bool {
        return lhs.id == rhs.id
    }
}

let previewLeague = [
    League(id: "id1", name: "French Ligue 1", sport: "", alternate: ""),
    League(id: "id2", name: "French Ligue 2", sport: "", alternate: ""),
    League(id: "id3", name: "Scottish Premier League", sport: "", alternate: ""),
    League(id: "id4", name: "German Bundesliga", sport: "", alternate: ""),
]
