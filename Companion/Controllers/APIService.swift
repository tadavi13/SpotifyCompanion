//
//  APIService.swift
//
//  Created by Tyler Davis on 8/2/24.
//

import Foundation

/// APIService class for all functions needed to interact and get data from the Spotify WebAPI.
class APIService {
    
    // MARK: - URL Creation
    
    /// APIService for shared use across classes.
    static let shared = APIService()
    
    /// Gets the URL to open the SpotifyLogin page when opening the login WebView.
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
    
    /// Creates a URL Request to send to the Spotify Web API based on parameters provided.
    /// - Parameters:
    ///   - path: The path specified in the API URL request to access the data needed.
    ///   - queryItems: Specific filters specified in the API URL request for accessing data.
    ///   - httpMethod: What type of http method the API URL request will use.
    /// - Returns: A URLRequest with the specified path, queryItems, and httpMethod.
    func createURLRequest(_ path: String, _ queryItems: [URLQueryItem], _ httpMethod: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.apiHost
        components.path = path
        
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        // Could force crash, maybe make a guard.
        let token: String = UserDefaults.standard.value(forKey: "Authorization") as! String
        
        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = httpMethod
        
        return urlRequest
    }
    
    // MARK: - API Requests
    
    // Search function
    func getFollowedArtists() async throws -> [String] {
        
        // Variable declarations
        let path: String = "/v1/me/following"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "type", value: "artist")
        ]
        let httpMethod: String = "GET"
        
        guard let urlRequest = createURLRequest(path, queryItems, httpMethod) else { throw NetworkError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        let results = try decoder.decode(Response.self, from: data)
        
        let items = results.artists.items
     
        let artists = items.map({$0.name})
        return artists
    }
}

// MARK: - Response Structs

// Structs for response objects
struct Response: Codable {
    let artists: Artist
}

struct Artist: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name: String
}
