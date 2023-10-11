//
//  Team.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class Team: Equatable {
    let id: String
    let name: String
    let logo: String
    
    init(id: String = "", name: String, logo: String = "") {
        self.id = id
        self.name = name
        self.logo = logo
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
}

let previewTeam = [
    Team(id: "id1", name: "Paris SG", logo: "https://www.thesportsdb.com/images/media/team/badge/undmwf1679830546.png"),
    Team(id: "id2", name: "Arsenal", logo: "https://www.thesportsdb.com/images/media/team/badge/uyhbfe1612467038.png"),
    Team(id: "id3", name: "Aston Villa", logo: "https://www.thesportsdb.com/images/media/team/badge/gev5lp1679951447.png"),
    Team(id: "id4", name: "Bournemouth", logo: "https://www.thesportsdb.com/images/media/team/badge/y08nak1534071116.png"),
]
