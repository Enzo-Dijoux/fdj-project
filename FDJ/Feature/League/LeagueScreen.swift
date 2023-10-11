//
//  LeagueScreen.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import SwiftUI
import Factory

struct LeagueScreenRoute: View {
    @StateObject private var _leagueViewModel = Container.shared.leagueViewModel()
    @StateObject private var _teamViewModel = Container.shared.teamViewModel()

    var body: some View {
        let teamState = _teamViewModel.state
        LeagueScreen(leagueState: _leagueViewModel.state, teamState: teamState, onLeaguePressed: { league in
            _teamViewModel.fetch(league: league)
        }, onSearchChanged: { search in
            if !teamState.isInitial() {
                _teamViewModel.resetState()
            }
        })
    }
}

private struct LeagueScreen: View {
    let leagueState: LeagueUiState
    let teamState: TeamUiState
    let onLeaguePressed: (_ league: String) -> Void
    let onSearchChanged: (_ search: String) -> Void

    var body: some View {
        switch leagueState {
        case .loading:
            LoadingView()
        case .success(let leagues):
            SuccessView(teamState: teamState, leagues: leagues, onSearchChanged: onSearchChanged, onLeaguePressed: onLeaguePressed)
        case .error(let message):
            ErrorView(message: message)
        }
    }
}

private struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

private struct ErrorView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.title)
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.red)
    }
}

private struct SuccessView: View {
    let teamState: TeamUiState
    let leagues: [League]
    let onSearchChanged: (_ search: String) -> Void
    let onLeaguePressed: (_ league: String) -> Void

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            switch teamState {
            case .initial:
                LeagueList(leagues: leagues, searchText: searchText, onLeaguePressed: onLeaguePressed)
            case .loading:
                LoadingView()
            case .success(let teams):
                TeamListView(teams: teams)
            case .error(let message):
                ErrorView(message: message)
            }
        }
        .searchable(text: $searchText, prompt: Text("Search by league"))
        .onChange(of: searchText) { newValue in
            onSearchChanged(newValue)
        }
    }
            
    private struct LeagueList: View {
        let leagues: [League]
        let searchText: String
        let onLeaguePressed: (_ league: String) -> Void

        var body: some View {
            List {
                ForEach(searchResults(leagues: leagues), id: \.self) { name in
                    Button {
                        onLeaguePressed(name)
                    } label: {
                        Text(name)
                    }.buttonStyle(.plain)
                }
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
    
    //TODO: We can use a dimension file instead of adding directly the spacing/sizes
    private struct TeamListView: View {
        let teams: [Team]
        
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(teams, id: \.id) { team in
                        FImage(url: URL(string: team.logo))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                    }
                }
                .padding()
            }
        }
    }
}

//TODO: Setup all previews
//struct LeagueScreenSuccess_Previews: PreviewProvider {
//    static var previews: some View {
//        //TODO: Add mock leagues
//        LeagueScreen(state: .success(leagues: []), onSearch: {_ in})
//    }
//}
//
//struct LeagueScreenLoading_Previews: PreviewProvider {
//    static var previews: some View {
//        LeagueScreen(state: .loading, onSearch: {_ in})
//    }
//}
//
//struct LeagueScreenError_Previews: PreviewProvider {
//    static var previews: some View {
//        LeagueScreen(state: .error(message: "Error"), onSearch: {_ in})
//    }
//}
