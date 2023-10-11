//
//  LeagueViewModelTests.swift
//  FDJTests
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import XCTest
import Factory
@testable import FDJ

class LeagueViewModelTests: XCTestCase {
    var mockRepository: MockLeagueRepository!

    override func setUp() {
        super.setUp()
        Container.shared.reset()
        mockRepository = MockLeagueRepository()
    }
    
    func testInitialStateIsLoading() {
        let viewModel = Container.shared.leagueViewModel()
        let initialState = viewModel.state

        XCTAssertTrue(initialState.isLoading())
    }

    func testSuccessfulFetchUpdatesStateToSuccess() {
        let leagues = [League(name: "Premier League"), League(name: "La Liga")]
        mockRepository.resource = FResource.success(ResourceSuccess(data: leagues))
        Container.shared.leagueRepository.register {
            self.mockRepository
        }
        let viewModel = Container.shared.leagueViewModel()
        
        switch viewModel.state {
        case .success(let retrievedLeagues):
            XCTAssertEqual(retrievedLeagues, leagues)
        default:
            XCTFail("Expected success state, got \(viewModel.state)")
        }
    }

    func testFetchWithErrorUpdatesStateToError() {
        let errorDescription = "An error occured"
        mockRepository.resource = FResource.error(ResourceError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : errorDescription])))
        Container.shared.leagueRepository.register {
            self.mockRepository
        }
        let viewModel = Container.shared.leagueViewModel()

        switch viewModel.state {
        case .error(let message):
            XCTAssertEqual(message, errorDescription)
        default:
            XCTFail("Expected error state, got \(viewModel.state)")
        }
    }

    func testFilterLeaguesWithMatchingText() {
        let leagues = [League(name: "Premier League"), League(name: "La Liga")]

        let viewModel = Container.shared.leagueViewModel()
        
        let result = viewModel.filterLeagues(leagues: leagues, searchText: "Premier")

        XCTAssertEqual(result, [League(name: "Premier League")])
    }

    func testFilterLeaguesWithoutMatchingTextReturnsEmptyArray() {
        let leagues = [League(name: "Premier League"), League(name: "La Liga")]
        
        let viewModel = Container.shared.leagueViewModel()

        let result = viewModel.filterLeagues(leagues: leagues, searchText: "Bundesliga")

        XCTAssertTrue(result.isEmpty)
    }

    func testFilterLeaguesWithEmptyTextReturnsOriginalList() {
        let leagues = [League(name: "Premier League"), League(name: "La Liga")]
        
        let viewModel = Container.shared.leagueViewModel()

        let result = viewModel.filterLeagues(leagues: leagues, searchText: "")

        XCTAssertEqual(result, leagues)
    }
}
