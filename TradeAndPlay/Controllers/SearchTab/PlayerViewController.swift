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
    var messageStorage: MessageStorage?
    var discussions: [Discussion]?
    var discussion: Discussion?
    
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
            guard let strongSelf = self, let fakeUser = strongSelf.fakeUsers?[indexPath.row] else {return}
            strongSelf.messageStorage?.fetchDiscussionByUser(named: (fakeUser.nickName), completionHandler: { result in
                switch result {
                case .failure(let error):
                    print(error)
                    strongSelf.messageStorage?.addNewDiscussion(recipient: fakeUser)
                case .success(let discussion):
                    strongSelf.discussion = discussion
                    strongSelf.performSegue(withIdentifier: PlayerViewController.segueId, sender: nil)
                }
            })
        }
        return cell
    }
}
