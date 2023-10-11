//
//  LeagueResponse.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class LeagueResponse {
    let leagues: [League]
    
    init(leagues: [League] = []) {
        self.leagues = leagues
    }
}
