//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Ritwik Singh on 04/01/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance
    
    private let baseURL = "https://api.github.com/users/"
    
    func fetchUserDetails(username: String, completion: @escaping (Result<dataUser, Error>) -> Void) {
        let endpoint = baseURL + "\(username)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidResponse))
                }
                return
            }
            
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    let user = try decoder.decode(dataUser.self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        completion(.success(user))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }
    
    func fetchFollowersOrFollowing(username: String, isFollowers: Bool, page: Int, completion: @escaping (Result<[dataFollower], Error>) -> Void) {
        let type = isFollowers ? "followers" : "following"
        let endpoint = baseURL + "\(username)/\(type)?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidResponse))
                }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let followers = try decoder.decode([dataFollower].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(followers))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }
}
