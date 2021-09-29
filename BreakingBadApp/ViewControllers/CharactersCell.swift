//
//  CharactersCell.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit
import Alamofire

class CharactersCell: UICollectionViewCell {
    
    @IBOutlet var imageCharacter: UIImageView!
    @IBOutlet var nameCharacter: UILabel!
    
    func configure(with character: Character) {
        nameCharacter.text = character.name
        
        getImage(url: character.img ?? "")
    }
    
    private func getImage(url: String) {
        NetworkManager.shared.fetchImageWithAlamofire(from: url) { result in
            switch result {
            case .success(let data):
                self.imageCharacter.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
