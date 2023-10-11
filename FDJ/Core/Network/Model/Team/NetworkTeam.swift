//
//  NetworkTeam.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension TeamService.NetworkTeamReponse {
    class NetworkTeam: Decodable {
        let id: String
        let logo: String
        
        enum CodingKeys: String, CodingKey {
            case id = "idTeam"
            case logo = "strTeamLogo"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = values.decodeIfPresentSafe(String.self, forKey: .id, defaultValue: "")
            logo = values.decodeIfPresentSafe(String.self, forKey: .logo, defaultValue: "")
        }
    }
}