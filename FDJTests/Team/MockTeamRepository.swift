//
//  MockTeamRepository.swift
//  FDJTests
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Combine
@testable import FDJ

class MockTeamRepository: TeamRepository {
    var resource: FResource<[Team]>!

    func retrieve(league: String) -> FDJ.RepositoryPublisher<[FDJ.Team]> {
        return Just(resource).eraseToAnyPublisher()
    }
}
