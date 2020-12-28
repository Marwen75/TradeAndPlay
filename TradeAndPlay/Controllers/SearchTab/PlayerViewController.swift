//
//  PlayerViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 12/12/2020.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var playersTableView: UITableView!
    
    // MARK: - Properties
    static let segueId = "playerToChat"
    var fakeUsers: [FakeUser]?
    var messageStorage: MessageStorage?
    var discussions: [Discussion]?
    var discussion: Discussion?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlayerViewController.segueId {
            let chatVC = segue.destination as! ChatViewController
            chatVC.messageStorage = messageStorage
            chatVC.discussion = discussion
        }
    }
    
    // MARK: - Methods
    private func configureTableView() {
        playersTableView.register(cellType: PlayerTableViewCell.self)
        playersTableView.rowHeight = 150
    }
}

// MARK: - Table view data source
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
            guard let strongSelf = self, let fakeUser = strongSelf.fakeUsers?[indexPath.row] else {return}
            strongSelf.messageStorage?.fetchDiscussionByUser(named: (fakeUser.nickName), completionHandler: { result in
                switch result {
                case .failure(_):
                    strongSelf.messageStorage?.addNewDiscussion(recipient: fakeUser, completionHandler: { discussion in
                        strongSelf.discussion = discussion
                        strongSelf.performSegue(withIdentifier: PlayerViewController.segueId, sender: nil)
                    })
                case .success(let discussion):
                    strongSelf.discussion = discussion
                    strongSelf.performSegue(withIdentifier: PlayerViewController.segueId, sender: nil)
                }
            })
        }
        return cell
    }
}
