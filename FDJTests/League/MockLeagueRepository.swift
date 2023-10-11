//
//  MockLeagueRepository.swift
//  FDJTests
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Combine
@testable import FDJ

class MockLeagueRepository: LeagueRepository {
    var resource: FResource<[League]>!

    func retrieve() -> FDJ.RepositoryPublisher<[FDJ.League]> {
        return Just(resource).eraseToAnyPublisher()
    }
}
