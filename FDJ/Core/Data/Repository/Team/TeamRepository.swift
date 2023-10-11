//
//  TeamRepository.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation

protocol TeamRepository {
    func retrieve(league: String) -> RepositoryPublisher<[Team]>
}
