//
//  CharactersCell.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class CharactersCell: UICollectionViewCell {
    
    @IBOutlet var imageCharacter: UIImageView!
    @IBOutlet var nameCharacter: UILabel!
    
    func configure(with character: Character) {
        nameCharacter.text = character.name
        
        DispatchQueue.global().async {
            guard let url = URL(string: character.img ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.imageCharacter.image = UIImage(data: imageData)
            }
        }
    }
}
