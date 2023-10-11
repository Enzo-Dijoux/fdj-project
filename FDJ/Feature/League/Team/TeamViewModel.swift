//
//  TeamViewModel.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Factory

class TeamViewModel: ObservableObject {
    @Injected(\.teamRepository) private var teamRepository
    
    @Published private(set) var state: TeamUiState = .initial
    
    func fetch(league: String) {
        teamRepository.retrieve(league: league)
            .map({ [weak self] resource in
                var finalState = TeamUiState.initial
                guard let `self` else { return finalState }
                resource.onLoading { _ in
                    finalState = .loading
                }.onSuccess { success in
                    finalState = .success(teams: self.filteredTeams(success.data))
                }.onError { resourceError in
                    finalState = .error(message: (resourceError.error?.localizedDescription).orEmpty)
                }
                return finalState
            })
            .assign(to: &$state)
    }
    
    func resetState() {
        self.state = .initial
    }
    
    private func filteredTeams(_ teams: [Team]) -> [Team] {
        let teamsSortedByName = sortTeamsByName(teams)
        return filterTeamsByPairElement(teamsSortedByName)
    }
    
    /// Filter teams by name in anti-alphabetical order.
    private func sortTeamsByName(_ teams: [Team]) -> [Team] {
        teams.sorted { first, second in
            first.name > second.name
        }
    }
    
    /// Filter teams to display only pair elements
    private func filterTeamsByPairElement(_ teams: [Team]) -> [Team] {
        return teams.enumerated().filter({ element in
            element.offset % 2 == 0
        }).map({ element in
            element.element
        })
    }
}

enum TeamUiState {
    case initial
    case loading
    case success(teams: [Team])
    case error(message: String)
    
    func isLoading() -> Bool {
        switch self {
            case .loading: return true
            default: break
        }
        return false
    }
    
    func isInitial() -> Bool {
        switch self {
            case .initial: return true
            default: break
        }
        return false
    }
    
    func getTeams() -> [Team] {
        switch self {
            case .success(let teams): return teams
            default: break
        }
        return []
    }
}
