//
//  Character.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

struct Character: Decodable {
    let name: String?
    let img: String?
    let status: String?
    let nickname: String?
    
    init(charactersData: [String: Any]) {
        name = charactersData["name"] as? String
        img = charactersData["img"] as? String
        status = charactersData["status"] as? String
        nickname = charactersData["nickname"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String:Any]] else { return [] }
        return charactersData.compactMap { Character(charactersData: $0)}
    }
}
