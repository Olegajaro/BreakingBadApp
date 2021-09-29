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
    
    private var randomCharacter: Character!
    private let networking = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchRandomCharacter()
    }
    
    private func fetchRandomCharacter() {
        networking.fetchCharactersWithAlamofire(from: Link.breakingBad.rawValue) { result in
            switch result {
            case .success(let characters):
                self.randomCharacter = characters.randomElement()
                self.nameLabel.text = "Name: \(self.randomCharacter.name ?? "")"
                self.nicknameLabel.text = "Nickname: \(self.randomCharacter.nickname ?? "")"
                self.statusLabel.text = "Status: \(self.randomCharacter.status ?? "")"
                self.getImage(url: self.randomCharacter.img ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(url: String) {
        networking.fetchImageWithAlamofire(from: url) { result in
            switch result {
            case .success(let data):
                self.characterImage.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
