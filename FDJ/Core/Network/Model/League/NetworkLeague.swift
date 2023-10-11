//
//  NetworkLeague.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension LeagueService.NetworkLeagueReponse {
    class NetworkLeague: Decodable {
        let id: String
        let name: String
        let sport: String
        let alternate: String
        
        enum CodingKeys: String, CodingKey {
            
            case id = "idLeague"
            case name = "strLeague"
            case sport = "strSport"
            case alternate = "strLeagueAlternate"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = values.decodeIfPresentSafe(String.self, forKey: .id, defaultValue: "")
            name = values.decodeIfPresentSafe(String.self, forKey: .name, defaultValue: "")
            sport = values.decodeIfPresentSafe(String.self, forKey: .sport, defaultValue: "")
            alternate = values.decodeIfPresentSafe(String.self, forKey: .alternate, defaultValue: "")
        }
    }
}

extension LeagueService.NetworkLeagueReponse.NetworkLeague {
    func asExternalModel() -> League {
        League(id: id, name: name, sport: sport, alternate: alternate)
    }
}
