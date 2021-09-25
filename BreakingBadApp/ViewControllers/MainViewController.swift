//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func randomCharacterButtonPressed() {
        performSegue(withIdentifier: "showCharacter", sender: nil)
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let randomVC = segue.destination as? RandomViewController else { return }
            randomVC.fetchRandomCharacter()
        }
    }
    
    @IBAction func allCharacterButtonPressed() {
        performSegue(withIdentifier: "showAll", sender: nil)
    }
}

