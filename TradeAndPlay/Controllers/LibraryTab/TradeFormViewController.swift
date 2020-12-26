//
//  TradeFormViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 24/12/2020.
//

import UIKit

class TradeFormViewController: UIViewController {
    
    @IBOutlet weak var confirmTradeButton: UIButton!
    @IBOutlet weak var customTextField: CustomTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var fakeUsers = FakeUserData.fakeUsers
    var fakeUser: FakeUser?
    var gameStorage: GameStorage?
    var ownedGame: OwnedGame?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirmTradeButtonTaped(_ sender: Any) {
        if checkIfUserExists(users: fakeUsers) == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.displayAlert(title: "Oups!", message: "No user found with this Name")
        }
    }
    
    private func checkIfUserExists(users: [FakeUser]) -> Bool {
        toggleActivityIndicator(shown: true)
        let userNickName = customTextField.gameTextField.text
        guard let ownedGame = ownedGame else {return false}
        for fakeUser in users {
            if fakeUser.nickName == userNickName {
                toggleActivityIndicator(shown: false)
                self.fakeUser = fakeUser
                self.gameStorage?.addTrade(game: ownedGame, recipient: fakeUser)
                return true
            }
        }
        toggleActivityIndicator(shown: false)
        return false
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        confirmTradeButton.isHidden = shown
    }
}
