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
    
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        characterImage.layer.cornerRadius = 60
        
        fetchRandomCharacter()
    }
    
    func configure(with character: Character) {
        nameLabel.text = "Name: \(character.name ?? "")"
        nicknameLabel.text = "Nickname: \(character.nickname ?? "")"
        statusLabel.text = "Status: \(character.status ?? "")"
        
        DispatchQueue.global().async {
            guard let url = URL(string: character.img ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: imageData)
            }
        }
    }
    
    func fetchRandomCharacter() {
        guard let url = URL(string: Link.breakingBad.rawValue) else { return }
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    guard let character = self.characters.randomElement() else { return }
                    self.configure(with: character)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
