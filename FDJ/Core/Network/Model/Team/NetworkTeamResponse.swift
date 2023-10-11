//
//  NetworkTeamResponse.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension TeamService {
    class NetworkTeamReponse: Decodable {
        let teams: [NetworkTeam]
        
        enum CodingKeys: String, CodingKey {
            
            case teams = "teams"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            teams = values.decodeIfPresentSafe([NetworkTeam].self, forKey: .teams, defaultValue: [])
        }
    }
}

extension TeamService.NetworkTeamReponse {
    func asExternalModel() -> TeamResponse {
        TeamResponse(teams: teams.map({ network in
            network.asExtenalModel()
        }))
    }
}
