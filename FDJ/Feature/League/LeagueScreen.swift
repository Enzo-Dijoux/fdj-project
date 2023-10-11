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
                    ForEach(filteredTeams(teams), id: \.id) { team in
                        FImage(url: URL(string: team.logo))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                    }
                }
                .padding()
            }
        }
        
        private func filteredTeams(_ teams: [Team]) -> [Team] {
            //Filter teams by name in anti-alphabetical order.
            let teamsSortedByName = teams.sorted { first, second in
                first.name > second.name
            }
            //Filter teams to display only pair elements
            let teamFiltered = teamsSortedByName.enumerated().filter({ element in
                element.offset % 2 == 0
            }).map({ element in
                element.element
            })
            return teamFiltered
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

struct LeagueScreenSuccess_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .initial, onLeaguePressed: {_ in}, onSearchChanged: {_ in})
    }
}

struct LeagueScreenSuccessTeamSuccess_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .success(teams: previewTeam), onLeaguePressed: {_ in}, onSearchChanged: {_ in})
    }
}

struct LeagueScreenSuccessTeamError_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .error(message: "Error occured on team fetched"), onLeaguePressed: {_ in}, onSearchChanged: {_ in})
    }
}

struct LeagueScreenSuccessTeamLoading_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .loading, onLeaguePressed: {_ in}, onSearchChanged: {_ in})
    }
}

struct LeagueScreenLoading_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .loading, teamState: .initial, onLeaguePressed: {_ in}, onSearchChanged: {_ in})
    }
}

struct LeagueScreenError_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .error(message: "Error occured"), teamState: .initial, onLeaguePressed: {_ in}, onSearchChanged: {_ in})
    }
}
