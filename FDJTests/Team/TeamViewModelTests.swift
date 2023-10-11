//
//  TeamViewModelTests.swift
//  FDJTests
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import XCTest
import Factory
@testable import FDJ

class TeamViewModelTests: XCTestCase {
    var mockRepository: MockTeamRepository!
    
    override func setUp() {
        super.setUp()
        Container.shared.reset()
        mockRepository = MockTeamRepository()
    }
    
    func testInitialStateIsInitial() {
        let viewModel = Container.shared.teamViewModel()
        XCTAssertTrue(viewModel.state.isInitial())
    }
    
    func testSuccessfulFetchUpdatesStateToSuccess() {
        let teams = [Team(name: "Team A"), Team(name: "Team B")]
        mockRepository.resource = FResource.success(ResourceSuccess(data: teams))
        Container.shared.teamRepository.register {
            self.mockRepository
        }
        let viewModel = Container.shared.teamViewModel()
        viewModel.fetch(league: "someLeague")
        
        switch viewModel.state {
        case .success(let retrievedTeams):
            XCTAssertEqual(retrievedTeams, [Team(name: "Team A")])
        default:
            XCTFail("Expected success state, got \(viewModel.state)")
        }
    }

    func testFetchWithErrorUpdatesStateToError() {
        let errorDescription = "An error occured"
        mockRepository.resource = FResource.error(ResourceError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : errorDescription])))
        Container.shared.teamRepository.register {
            self.mockRepository
        }
        let viewModel = Container.shared.teamViewModel()
        viewModel.fetch(league: "someLeague")
        
        switch viewModel.state {
        case .error(let message):
            XCTAssertEqual(message, errorDescription)
        default:
            XCTFail("Expected error state, got \(viewModel.state)")
        }
    }
    
    func testResetState() {
        mockRepository.resource = FResource.loading(ResourceLoading())
        Container.shared.teamRepository.register {
            self.mockRepository
        }
        let viewModel = Container.shared.teamViewModel()
        viewModel.fetch(league: "someLeague")
        
        viewModel.resetState()
        
        XCTAssertTrue(viewModel.state.isInitial())
    }
    
    func testFilterTeamsReturnsPairElementsAntiAlphabeticalOrder() {
        let teams = [Team(name: "Team A"), Team(name: "Team B"), Team(name: "Team C")]
        
        mockRepository.resource = FResource.success(ResourceSuccess(data: teams))
        Container.shared.teamRepository.register {
            self.mockRepository
        }
        let viewModel = Container.shared.teamViewModel()
        viewModel.fetch(league: "someLeague")
                
        XCTAssertEqual(viewModel.state.getTeams(), [Team(name: "Team C"), Team(name: "Team A")])
    }
}
