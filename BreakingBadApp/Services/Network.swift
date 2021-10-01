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
                    completion(.success(characters))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func fetchImageWithAlamofire(from url: String, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success (let data):
                    completion(.success(data))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    private init() {}
}

