//
//  LeagueRepository.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

protocol LeagueRepository {
    func retrieve() -> RepositoryPublisher<[League]>
}
