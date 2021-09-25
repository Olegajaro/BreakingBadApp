//
//  CharactersViewController.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class CharactersViewController: UICollectionViewController {
    
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! CharactersCell
        
        let character = characters[indexPath.item]
        cell.configure(with: character)
    
        return cell
    }

    func fetchCharacters() {
        guard let url = URL(string: Link.breakingBad.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                self.characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
