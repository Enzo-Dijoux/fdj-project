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
            .map({ resource in
                var finalState = TeamUiState.initial
                resource.onLoading { _ in
                    finalState = .loading
                }.onSuccess { success in
                    finalState = .success(teams: success.data)
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
}
