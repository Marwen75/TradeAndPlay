//
//  SearchViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 29/11/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var customTextField: CustomTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var researchSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var lookingForLabel: UILabel!
    
    
    static let segueId = "searchToGames"
    static let segueIdTwo = "searchToPlayers"
    
    var igdbService: IgdbService?
    var games: [Game] = []
    var users: [User] = []
    var dataStorage: DataStorage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SearchViewController.segueId {
            let gamesVC = segue.destination as! GamesViewController
            gamesVC.games = games
        }
    }
    
    @IBAction func searchButtonTaped(_ sender: Any) {
        if researchSwitch.isOn {
            searchPlayers()
        } else {
            searchGames()
        }
    }
    
    @IBAction func switchTaped(_ sender: UISwitch) {
        if sender.isOn {
            lookingForLabel.text = "Looking for a player ?"
            switchLabel.text = "Search by game name ?"
        } else {
            lookingForLabel.text = "Looking for a game ?"
            switchLabel.text = "Search by player name ?"
        }
    }
    
    
    private func searchGames() {
        guard let name = customTextField.gameTextField.text else {return}
        toggleActivityIndicator(shown: true)
        igdbService?.post(withName: name, completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let games):
                strongSelf.games = games
                strongSelf.performSegue(withIdentifier: SearchViewController.segueId, sender: nil)
            }
        })
    }
    
    private func searchPlayers() {
        guard let name = customTextField.gameTextField.text else {return}
        toggleActivityIndicator(shown: true)
        dataStorage?.fetchUsers(named: name, completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let users):
                strongSelf.users = users
            }
        })
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
