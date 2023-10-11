//
//  LeagueViewModel.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Factory

class LeagueViewModel: ObservableObject {
    @Injected(\.leagueRepository) private var leagueRepository
    
    @Published private(set) var state: LeagueUiState = .loading

    init() {
        fetch()
    }
    
    private func fetch() {
        leagueRepository.retrieve()
            .map({ resource in
                var finalState = LeagueUiState.loading
                resource.onLoading { _ in
                    finalState = .loading
                }.onSuccess { success in
                    finalState = .success(leagues: success.data)
                }.onError { resourceError in
                    finalState = .error(message: (resourceError.error?.localizedDescription).orEmpty)
                }
                return finalState
            })
            .assign(to: &$state)
    }
}

enum LeagueUiState {
    case loading
    case success(leagues: [League])
    case error(message: String)
    
    func isLoading() -> Bool {
        switch self {
            case .loading: return true
            default: break
        }
        return false
    }
}
