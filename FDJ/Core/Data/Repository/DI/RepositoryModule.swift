//
//  RepositoryModule.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Factory

extension Container {
    var leagueRepository: Factory<LeagueRepository> {
        self {
            LeagueRepositoryImpl(service: LeagueService()) as LeagueRepository
        }
    }
    
    var teamRepository: Factory<TeamRepository> {
        self {
            TeamRepositoryImpl(service: TeamService()) as TeamRepository
        }
    }
}
