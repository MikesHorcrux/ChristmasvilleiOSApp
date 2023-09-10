//
//  RequestPublisher.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation
import Combine

typealias RequestPublisher<ReturnType> = AnyPublisher<ReturnType, NetworkRequestError>
