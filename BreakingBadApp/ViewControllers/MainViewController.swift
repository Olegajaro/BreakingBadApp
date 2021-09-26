//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by Олег Федоров on 25.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func randomCharacterButtonPressed() {
        performSegue(withIdentifier: "showCharacter", sender: nil)
    }
    
    @IBAction func allCharacterButtonPressed() {
        performSegue(withIdentifier: "showAll", sender: nil)
    }
}

