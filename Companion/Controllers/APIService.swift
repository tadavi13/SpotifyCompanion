//
//  APIService.swift
//
//  @author Jason Dubon
//  @author Tyler Davis
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    // Gets the URL that contains the access token needed to access the Spotify Web API
    func getAccessTokenURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.authHost
        components.path = "/authorize"
        
        components.queryItems = APIConstants.authParams.map({URLQueryItem(name: $0, value: $1)})
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
    
    // Creates a URL Request to the Spotify Web API based on parameters.
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
