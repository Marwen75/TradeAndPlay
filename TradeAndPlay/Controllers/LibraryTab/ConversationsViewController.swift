//
//  ConversationsViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import UIKit

class ConversationsViewController: UIViewController {
    
    @IBOutlet weak var conversationTableView: UITableView!
    
    var discussions: [Discussion] = []
    var discussion: Discussion?
    var messageStorage: MessageStorage?
    var messages: [Message] = []
    var recipient: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageStorage?.fetchDiscussions(completionHandler: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let discussions):
                strongSelf.discussions = discussions
            }
        })
        conversationTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.messageStorage = messageStorage
            chatVC.messages = messages
            chatVC.discussion = discussion
        }
    }
    
    private func configureTableView() {
        conversationTableView.rowHeight = 100
        conversationTableView.register(cellType: ConversationTableViewCell.self)
    }
}

extension ConversationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipient = discussions[indexPath.row].recipient else {return}
        messageStorage?.fetchMessagesFromDiscussion(recipient: recipient, completionHandler: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let messages):
                strongSelf.messages = messages
                strongSelf.discussion = strongSelf.discussions[indexPath.row]
                strongSelf.performSegue(withIdentifier: "toChat", sender: nil)
            }
        })
    }
}

extension ConversationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ConversationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(discussion: discussions[indexPath.row])
        let sortedMsg = discussions[indexPath.row].messages?.allObjects as? [Message]
        if sortedMsg?.last?.isRead == true {
            cell.messageView.backgroundColor = .gray
        }
        return cell
    }
}
