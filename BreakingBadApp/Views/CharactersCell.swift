//
//  CharactersCell.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class CharactersCell: UICollectionViewCell {
    
    @IBOutlet var imageCharacter: CharacterImageView!
    @IBOutlet var nameCharacter: UILabel!
    
    func configure(with character: Character) {
        nameCharacter.text = "\(character.name ?? "")(\(character.nickname ?? ""))"
        
        imageCharacter.getImage(from: character.img ?? "")
//        NetworkManager.shared.fetchImage(from: character.img) { result in
//            switch result {
//            case .success(let data):
//                self.imageCharacter.image = UIImage(data: data)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
