//
//  APIConstants.swift
//
//  Created by Tyler Davis on 8/2/24.
//

import Foundation

/// Enum for the APIConstants needed when accessing the Spotify WebAPI
enum APIConstants {
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientId = "dd0ed5073e794beda6d89ac5040bff23"
    static let clientSecret = "e05487bcaf924251945b32e11d136aca"
    static let redirectUri = "https://www.google.com"
    static let responseType = "token"
    static let scopes = "user-follow-read"
   
    static var authParams = [
        "response_type": responseType,
        "client_id": clientId,
        "redirect_uri": redirectUri,
        "scope": scopes
    ]
}
