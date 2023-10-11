//
//  TeamResponse.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class TeamResponse {
    let teams: [Team]
    
    init(teams: [Team] = []) {
        self.teams = teams
    }
}
