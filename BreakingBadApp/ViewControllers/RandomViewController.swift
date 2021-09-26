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
        
        networking.getCharacters { (characters, _) -> () in
            guard let character = characters.randomElement() else { return }
            self.configure(with: character)
            self.activityIndicator.stopAnimating()
        }
    }
    
    func configure(with character: Character?) {
        nameLabel.text = "Name: \(character?.name ?? "")"
        nicknameLabel.text = "Nickname: \(character?.nickname ?? "")"
        statusLabel.text = "Status: \(character?.status ?? "")"
        
        DispatchQueue.global().async {
            guard let url = URL(string: character?.img ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: imageData)
            }
        }
    }
}
