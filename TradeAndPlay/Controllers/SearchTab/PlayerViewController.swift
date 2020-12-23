//
//  PlayerViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 12/12/2020.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    
    static let segueId = "playerToChat"
    var fakeUsers: [FakeUser]?
    var messages: [Message]?
    var messageStorage: MessageStorage?
    var discussion: Discussion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlayerViewController.segueId {
            let chatVC = segue.destination as! ChatViewController
            chatVC.messages = messages!
            chatVC.messageStorage = messageStorage
        }
    }
    
    private func configureTableView() {
        playersTableView.register(cellType: PlayerTableViewCell.self)
        playersTableView.rowHeight = 150
    }
}

extension PlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PlayerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fakeUsers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let fakeUser = fakeUsers?[indexPath.row] {
            cell.configure(withUser: fakeUser)
        }
        cell.didTapContact = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.messageStorage?.fetchMessagesFromDiscussion(recipient: (strongSelf.fakeUsers?[indexPath.row].nickName)!, completionHandler: { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let messages):
                    strongSelf.messages = messages
                    strongSelf.performSegue(withIdentifier: PlayerViewController.segueId, sender: nil)
                }
            })
        }
        return cell
    }
}
