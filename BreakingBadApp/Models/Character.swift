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
    
    init(characterData: [String: Any]) {
        name = characterData["name"] as? String
        img = characterData["img"] as? String
        status = characterData["status"] as? String
        nickname = characterData["nickname"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String:Any]] else { return [] }
        return charactersData.compactMap { Character(characterData: $0)}
    }
}
