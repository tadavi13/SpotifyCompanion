//  
//  NetworkError.swift
//
//  Created by Tyler Davis on 8/2/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case generalError
}
