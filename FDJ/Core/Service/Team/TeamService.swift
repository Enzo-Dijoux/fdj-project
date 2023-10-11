//
//  TeamService.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class TeamService: BaseService {
    
    func get(league: String) async -> FResponse<NetworkTeamReponse>? {
        let parser = DecodableParser<NetworkTeamReponse>()
        let path = "search_all_teams.php"
        let parameters: [String: Any] = [
            "l": league,
        ]
        return await getRequest(path: path, parameters: parameters)
    }
}
