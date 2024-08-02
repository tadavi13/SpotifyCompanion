//
//  APIConstants.swift
//  SpotifyApp
//
//  Created by YouTube on 9/22/22.
//

import Foundation

enum APIConstants {
    static let apiHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientId = "dd0ed5073e794beda6d89ac5040bff23"
    static let clientSecret = "e05487bcaf924251945b32e11d136aca"
    static let redirectUri = "https://www.google.com"
    static let responseType = "token"
    static let scopes = "user-read-private"
   
    static var authParams = [
        "response_type": responseType,
        "client_id": clientId,
        "redirect_uri": redirectUri,
        "scope": scopes
    ]
}

