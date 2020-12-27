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
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var platformPickerView: CustomPicker!
    
    
    static let segueId = "searchToGames"
    
    var igdbService: IgdbService?
    var games: [GameModel] = []
    var messageStorage: MessageStorage?
    var gameStorage: GameStorage?
    var platform = "PlayStation"
    let platforms: [String] = ["PlayStation",
                               "PlayStation 2", "PlayStation 3", "PlayStation 4",
                               "PlayStation 5", "Xbox", "Xbox 360",
                               "Xbox One","Xbox Series",
                               "Nintendo Entertainment System (NES)",
                               "Super Nintendo Entertainment System (SNES)",
                               "Nintendo 64","Nintendo GameCube", "Wii",
                               "Wii U", "Nintendo Switch", "TurboGrafx-16/PC Engine",
                               "Turbografx-16/PC Engine CD","Neo Geo CD",
                               "Neo Geo AES", "Sega Master System",
                               "Sega Mega Drive/Genesis", "Sega Saturn", "Dreamcast"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
        customTextField.gameTextField.delegate = self
        platformPickerView.platformPicker.delegate = self
        platformPickerView.platformPicker.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SearchViewController.segueId {
            let gamesVC = segue.destination as! GamesViewController
            gamesVC.platform = platform
            gamesVC.games = games
            gamesVC.gameStorage = gameStorage
            gamesVC.messageStorage = messageStorage
        }
    }
    
    @IBAction func searchButtonTaped(_ sender: Any) {
        do {
            try searchGames()
        } catch let error as ApiError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups!", message: "Une erreur est survenue.")
        }
    }
    
    private func searchGames() throws {
        guard let name = customTextField.gameTextField.text else {return}
        toggleActivityIndicator(shown: true)
        guard InternetConnectionChecker.isConnectedToNetwork() else {
            toggleActivityIndicator(shown: false)
            throw ApiError.noInternet
        }
        igdbService?.post(withName: name, platform: platform, completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let games):
                guard games.count > 0 else {
                    strongSelf.displayAlert(title: "Oups!", message: "No game found with this name on this platform, check for misspeling and try again.")
                    return
                }
                strongSelf.games = games
                strongSelf.performSegue(withIdentifier: SearchViewController.segueId, sender: nil)
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

extension SearchViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        platform = platforms[row]
    }
}

extension SearchViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return platforms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return platforms[row]
    }
}
