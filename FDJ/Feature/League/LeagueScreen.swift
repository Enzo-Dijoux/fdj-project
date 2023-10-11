//
//  LeagueScreen.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import SwiftUI
import Factory

struct LeagueScreenRoute: View {
    @StateObject private var _viewModel = Container.shared.leagueViewModel()

    var body: some View {
        LeagueScreen(state: _viewModel.state, onSearch: { league in
            //TODO: Call search api
        })
    }
}

private struct LeagueScreen: View {
    let state: LeagueUiState
    let onSearch: (_ league: String) -> Void
    
    @State private var searchText = ""
    
    var body: some View {
        switch state {
        case .loading:
            ProgressView()
        case .success(let leagues):
            NavigationStack {
                List {
                    ForEach(searchResults(leagues: leagues), id: \.self) { name in
                        NavigationLink {
                            Text(name)
                        } label: {
                            Text(name)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
        case .error(let message):
            Text(message)
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.red)
        }
    }
    
    private func searchResults(leagues: [League]) -> [String] {
        var finalResult: [League] = leagues
        if !searchText.isEmpty {
            finalResult = leagues.filter({ league in
                league.name.lowercased().contains(searchText.lowercased())
            })
        }
        return finalResult.map { $0.name }
    }
}

struct LeagueScreenSuccess_Previews: PreviewProvider {
    static var previews: some View {
        //TODO: Add mock leagues
        LeagueScreen(state: .success(leagues: []), onSearch: {_ in})
    }
}

struct LeagueScreenLoading_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(state: .loading, onSearch: {_ in})
    }
}

struct LeagueScreenError_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(state: .error(message: "Error"), onSearch: {_ in})
    }
}
