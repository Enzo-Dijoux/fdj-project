//
//  ViewModelModule.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Factory

extension Container {
    var leagueViewModel: Factory<LeagueViewModel> {
        self { LeagueViewModel() }
    }
}
