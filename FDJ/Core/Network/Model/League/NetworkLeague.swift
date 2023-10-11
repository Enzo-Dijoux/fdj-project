//
//  NetworkLeague.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension LeagueService.NetworkLeagueReponse {
    class NetworkLeague: Decodable {
        let idLeague: String
        let strLeague: String
        let strSport: String
        let strLeagueAlternate: String
        
        enum CodingKeys: String, CodingKey {
            
            case idLeague = "idLeague"
            case strLeague = "strLeague"
            case strSport = "strSport"
            case strLeagueAlternate = "strLeagueAlternate"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            idLeague = values.decodeIfPresentSafe(String.self, forKey: .idLeague, defaultValue: "")
            strLeague = values.decodeIfPresentSafe(String.self, forKey: .strLeague, defaultValue: "")
            strSport = values.decodeIfPresentSafe(String.self, forKey: .strSport, defaultValue: "")
            strLeagueAlternate = values.decodeIfPresentSafe(String.self, forKey: .strLeagueAlternate, defaultValue: "")
        }
    }
}

extension LeagueService.NetworkLeagueReponse.NetworkLeague {
    func asExternalModel() -> League {
        League(id: idLeague, name: strLeague, sport: strSport, alternate: strLeagueAlternate)
    }
}
