//
//  RepositoryPublisher.swift
//  FDJ
//
//  Created by Enzo Dijoux on 11/10/2023.
//

import Foundation
import Combine

typealias RepositoryPublisher<T> = AnyPublisher<FResource<T>, Never>
