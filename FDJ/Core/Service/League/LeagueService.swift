//
//  LeagueService.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

class LeagueService: BaseService {
    
    func get() async -> FResponse<NetworkLeagueReponse>? {
        let parser = DecodableParser<NetworkLeagueReponse>()
        let path = "all_leagues.php"
        return await getRequest(path: path)
    }
}
