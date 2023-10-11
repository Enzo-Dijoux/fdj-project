//
//  TeamRepositoryImpl.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Combine

class TeamRepositoryImpl: TeamRepository {
    private let service: TeamService
    
    init(service: TeamService) {
        self.service = service
    }
    
    func retrieve(league: String) -> RepositoryPublisher<[Team]> {
        let subject = CurrentValueSubject<FResource<[Team]>, Never>(.loading(ResourceLoading()))
        Task {
            let resource: FResource<[Team]> = await service.get(league: league).map({ response in
                var resource: FResource<[Team]> = .loading(ResourceLoading())
                response.onSuccess(completion: { data in
                    resource = .success(ResourceSuccess(data: data.asExternalModel().teams))
                }).onFail(completion: { serviceError in
                    resource = .error(ResourceError(serviceError))
                })
                return resource
            }) ?? .loading(ResourceLoading())
            subject.send(resource)
        }
        return subject.eraseToAnyPublisher()
    }
}
