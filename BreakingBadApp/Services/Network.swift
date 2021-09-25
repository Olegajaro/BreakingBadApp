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

//class NetworkManager {
//    static let shared = NetworkManager()
//
//    func getCharacter(completion: @escaping (Character?, Error?) -> ()) {
//        func fetchCharacters() {
//            guard let url = URL(string: Link.breakingBad.rawValue) else { return }
//
//            URLSession.shared.dataTask(with: url) { data, _, error in
//                guard let data = data else {
//                    print(error?.localizedDescription ?? "No error description")
//                    return
//                }
//
//                do {
//                    let characters = try JSONDecoder().decode([Character].self, from: data)
//                    DispatchQueue.main.async {
//                        completion(characters, nil)
//                    }
//                } catch let error {
//                    completion(nil, error)
//                }
//            }.resume()
//
//        }
//
//        private init() {}
//    }
//}
