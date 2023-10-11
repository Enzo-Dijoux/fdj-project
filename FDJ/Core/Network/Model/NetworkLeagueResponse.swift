//
//  NetworkLeagueResponse.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension LeagueService {
    class NetworkLeagueReponse: Decodable {
        let leagues: [NetworkLeague]
        
        enum CodingKeys: String, CodingKey {
            
            case leagues = "leagues"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            leagues = values.decodeIfPresentSafe([NetworkLeague].self, forKey: .leagues, defaultValue: [])
        }
    }
}
