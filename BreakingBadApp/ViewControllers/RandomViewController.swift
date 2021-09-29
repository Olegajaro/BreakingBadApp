//
//  RandomCharacterViewController.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!

    private let networking = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchRandomCharacter()
    }
    
    private func configure(with character: Character?) {
        nameLabel.text = "Name: \(character?.name ?? "")"
        nicknameLabel.text = "Nickname: \(character?.nickname ?? "")"
        statusLabel.text = "Status: \(character?.status ?? "")"
        
        networking.fetchImage(from: character?.img) { result in
            switch result {
            case .success(let data):
                self.characterImage.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchRandomCharacter() {
        networking.fetchCharacters(from: Link.breakingBad.rawValue) { result in
            switch result {
            case .success(let characters):
                let character = characters.randomElement()
                self.configure(with: character)
            case .failure(let error):
                print(error)
            }
        }
    }
}
