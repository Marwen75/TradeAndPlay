//
//  ConversationsViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import UIKit

class ConversationsViewController: UIViewController {
    
    @IBOutlet weak var conversationTableView: UITableView!
    
    var senders: [String] = []
    var discussion: [String] = []
    var messageStorage: MessageStorage?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageStorage?.fetchSenders(completionHandler: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let senders):
                strongSelf.senders = senders
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.messages = discussion
        }
    }
    
    private func configureTableView() {
        conversationTableView.rowHeight = 100
        conversationTableView.register(cellType: ConversationTableViewCell.self)
    }
}

extension ConversationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messageStorage?.fetchDiscussion(senderName: senders[indexPath.row], completionHandler: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let discussion):
                strongSelf.discussion = discussion
                strongSelf.performSegue(withIdentifier: "toChat", sender: nil)
            }
        })
    }
}

extension ConversationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return senders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ConversationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(sender: senders[indexPath.row])
        return cell
    }
}
