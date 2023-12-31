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
        let strTeam: String
        let strTeamBadge: String
        
        enum CodingKeys: String, CodingKey {
            case idTeam = "idTeam"
            case strTeam = "strTeam"
            case strTeamBadge = "strTeamBadge"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            idTeam = values.decodeIfPresentSafe(String.self, forKey: .idTeam, defaultValue: "")
            strTeam = values.decodeIfPresentSafe(String.self, forKey: .strTeam, defaultValue: "")
            strTeamBadge = values.decodeIfPresentSafe(String.self, forKey: .strTeamBadge, defaultValue: "")
        }
    }
}

extension TeamService.NetworkTeamReponse.NetworkTeam {
    func asExtenalModel() -> Team {
        Team(id: idTeam, name: strTeam, logo: strTeamBadge)
    }
}
