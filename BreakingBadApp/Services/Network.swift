//
//  Network.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import Foundation

enum Link: String {
   case breakingBad = "https://www.breakingbadapi.com/api/characters?l"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func fetchCharacters(from url: String?, completion: @escaping(Result<[Character], NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do{
                let characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(characters))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    private init() {}
}

