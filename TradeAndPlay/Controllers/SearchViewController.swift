//
//  SearchViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 29/11/2020.
//

import UIKit
import IGDB_SWIFT_API

class SearchViewController: UIViewController {
    
    static let segueId = "searchToGames"
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    let igdbService = IgdbService(client: IgdbWrapperClient() as ClientProtocol)
    var games: [Proto_Game] = []
    
    
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
        searchGames()
    }
    
    @IBAction func okButtonTaped(_ sender: Any) {
        gameLabel.text = gameTextField.text
        gameTextField.text = ""
    }
    
    @IBAction func clearButtonTaped(_ sender: Any) {
        gameLabel.text = ""
    }
    
    
    private func searchGames() {
        guard let name = gameLabel.text else {return}
        toggleActivityIndicator(shown: true)
        igdbService.getGames(withName: name, completionHandler: { result in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.toggleActivityIndicator(shown: false)
                switch result {
                case .failure(let error):
                    strongSelf.displayAlert(title: "Oups", message: error.localizedDescription)
                case .success(let searchResult):
                    strongSelf.games = searchResult.games
                    strongSelf.performSegue(withIdentifier: SearchViewController.segueId, sender: nil)
                }
            }
        })
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
}
