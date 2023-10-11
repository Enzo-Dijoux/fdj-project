//
//  LeagueRepositoryImpl.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Combine

class LeagueRepositoryImpl: LeagueRepository {
    private let service: LeagueService
    
    init(service: LeagueService) {
        self.service = service
    }
    
    func retrieve() -> RepositoryPublisher<[League]> {
        let subject = CurrentValueSubject<FResource<[League]>, Never>(.loading(ResourceLoading()))
        Task {
            let resource = await service.get().map({ response in
                var resource: FResource<[League]> = .loading(ResourceLoading())
                response.onSuccess(completion: { data in
                    resource = .success(ResourceSuccess(data: data.asExternalModel().leagues))
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
