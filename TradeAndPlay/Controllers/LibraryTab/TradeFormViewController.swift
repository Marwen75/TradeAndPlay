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
        do {
            try checkIfUserExists(users: fakeUsers)
        } catch let error as DataStorageError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            print("pblm")
        }
    }
    
    private func checkIfUserExists(users: [FakeUser]) throws {
        let userNickName = customTextField.gameTextField.text
        guard let ownedGame = ownedGame else {
            throw DataStorageError.noGameFound
        }
        for fakeUser in fakeUsers {
            if fakeUser.nickName == userNickName {
                self.fakeUser = fakeUser
                self.gameStorage?.addTrade(game: ownedGame, recipient: fakeUser)
                displayAlert(title: "Done !", message: "You traded \(ownedGame.name) with \(fakeUser)")
                break
                } else {
                throw DataStorageError.noPlayerFound
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        confirmTradeButton.isHidden = shown
    }
}
