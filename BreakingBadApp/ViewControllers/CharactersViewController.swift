//
//  CharactersViewController.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class CharactersViewController: UICollectionViewController {
    
    private var characters: [Character] = []
    private var spinnerView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerView = showSpinner(in: collectionView)
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
    
    // MARK: - Private Methods
    private func fetchCharacters() {
        NetworkManager.shared.fetchCharacters(from: Link.breakingBad.rawValue) { result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.spinnerView?.stopAnimating()
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
