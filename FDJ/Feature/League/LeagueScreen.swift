//
//  LeagueScreen.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import SwiftUI
import Factory

struct LeagueScreenRoute: View {
    @StateObject private var leagueViewModel = Container.shared.leagueViewModel()
    @StateObject private var teamViewModel = Container.shared.teamViewModel()

    var body: some View {
        let teamState = teamViewModel.state
        let leagueState = leagueViewModel.state
        LeagueScreen(leagueState: leagueState, teamState: teamState, onLeaguePressed: { league in
            teamViewModel.fetch(league: league)
        }, onSearchChanged: { search in
            if !teamState.isInitial() {
                teamViewModel.resetState()
            }
        }, leaguesFiltered: { search in
            leagueViewModel.filterLeagues(leagues: leagueState.getLeagues(), searchText: search)
        })
    }
}

private struct LeagueScreen: View {
    let leagueState: LeagueUiState
    let teamState: TeamUiState
    let onLeaguePressed: (_ league: String) -> Void
    let onSearchChanged: (_ search: String) -> Void
    let leaguesFiltered: (_ search: String) -> [League]

    var body: some View {
        switch leagueState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView(teamState: teamState, onSearchChanged: onSearchChanged, onLeaguePressed: onLeaguePressed, leaguesFiltered: leaguesFiltered)
        case .error(let message):
            ErrorView(message: message)
        }
    }
}

private struct SuccessView: View {
    let teamState: TeamUiState
    let onSearchChanged: (_ search: String) -> Void
    let onLeaguePressed: (_ league: String) -> Void
    let leaguesFiltered: (_ search: String) -> [League]

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            switch teamState {
            case .initial:
                LeagueList(leagues: leaguesFiltered(searchText).map({ league in
                    league.name
                }), onLeaguePressed: onLeaguePressed)
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
        let leagues: [String]
        let onLeaguePressed: (_ league: String) -> Void

        var body: some View {
            List {
                ForEach(leagues, id: \.self) { name in
                    Button {
                        onLeaguePressed(name)
                    } label: {
                        Text(name)
                    }.buttonStyle(.plain)
                }
            }
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
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .initial, onLeaguePressed: {_ in}, onSearchChanged: {_ in}, leaguesFiltered: {_ in
            return []
        })
    }
}

struct LeagueScreenSuccessTeamSuccess_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .success(teams: previewTeam), onLeaguePressed: {_ in}, onSearchChanged: {_ in}, leaguesFiltered: {_ in
            return []
        })
    }
}

struct LeagueScreenSuccessTeamError_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .error(message: "Error occured on team fetched"), onLeaguePressed: {_ in}, onSearchChanged: {_ in}, leaguesFiltered: {_ in
            return []
        })
    }
}

struct LeagueScreenSuccessTeamLoading_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .success(leagues: previewLeague), teamState: .loading, onLeaguePressed: {_ in}, onSearchChanged: {_ in}, leaguesFiltered: {_ in
            return []
        })
    }
}

struct LeagueScreenLoading_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .loading, teamState: .initial, onLeaguePressed: {_ in}, onSearchChanged: {_ in}, leaguesFiltered: {_ in
            return []
        })
    }
}

struct LeagueScreenError_Previews: PreviewProvider {
    static var previews: some View {
        LeagueScreen(leagueState: .error(message: "Error occured"), teamState: .initial, onLeaguePressed: {_ in}, onSearchChanged: {_ in}, leaguesFiltered: {_ in
            return []
        })
    }
}
