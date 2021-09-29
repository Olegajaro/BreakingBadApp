//
//  Network.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import Foundation
import Alamofire


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
    
    func fetchCharactersWithAlamofire(from url: String, completion: @escaping(Result<[Character], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters = Character.getCharacters(from: value)
                    DispatchQueue.main.async {
                        completion(.success(characters))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func fetchImageWithAlamofire(from url: String, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        AF.download(url)
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success:
                    DispatchQueue.global().async {
                        guard let imageData = dataResponse.value else {
                            completion(.failure(.noData))
                            return
                        }
                        DispatchQueue.main.async {
                            completion(.success(imageData))
                        }
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    private init() {}
}

