//
//  NetworkTeam.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

extension TeamService.NetworkTeamReponse {
    class NetworkTeam: Decodable {
        let idTeam: String
        let strTeamLogo: String
        
        enum CodingKeys: String, CodingKey {
            case idTeam = "idTeam"
            case strTeamLogo = "strTeamLogo"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            idTeam = values.decodeIfPresentSafe(String.self, forKey: .idTeam, defaultValue: "")
            strTeamLogo = values.decodeIfPresentSafe(String.self, forKey: .strTeamLogo, defaultValue: "")
        }
    }
}

extension TeamService.NetworkTeamReponse.NetworkTeam {
    func asExtenalModel() -> Team {
        Team(id: idTeam, logo: strTeamLogo)
    }
}
