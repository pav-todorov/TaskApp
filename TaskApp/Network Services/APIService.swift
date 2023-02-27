//
//  APIService.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import Foundation

class APIService {
    // MARK: Variables
    static let shared = APIService()
    
    // MARK: Initializers
    private init() {}
    
    func fetchUserProfile(with userName: String, and password: String) async throws -> ServerResponse {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "devapi.bevvy.com"
        components.path = "/api/signin"
        components.queryItems = [
            URLQueryItem(name: "email", value: userName),
            URLQueryItem(name: "password", value: password),
        ]
        
        guard let url = components.url else { return ServerResponse.wrongURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else { return ServerResponse.serverError }
        
        switch httpResponse.statusCode {
        case 200 ... 299:
            return ServerResponse.success
        case 400 ..< 500:
            return ServerResponse.wrongCredentials
        default:
            return ServerResponse.serverError
        }
    }
}


enum ServerResponse {
    case success
    case wrongCredentials
    case serverError
    case wrongURL
}
