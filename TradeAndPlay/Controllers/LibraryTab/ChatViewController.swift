//
//  ChatViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var userTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    private var placeholderLabel: UILabel!
    
    var messages: [Message] = []
    var messageStorage: MessageStorage?
    var discussion: Discussion?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let recipient = discussion?.recipient else {return}
        messageStorage?.fetchMessagesFromDiscussion(recipient: recipient, completionHandler: {[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                print(error)
            case .success(let messages):
                strongSelf.messages = messages
            }
        })
        messagesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        userTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Tap your text here."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (userTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        userTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (userTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !userTextView.text.isEmpty
    }
    
    @IBAction func sendButtonTaped(_ sender: Any) {
        sendMessage()
    }
    
    private func sendMessage() {
        let content: String = userTextView.text
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
        messageStorage?.addMessageToDiscussion(discussion: discussion!, content: content, completionHandler: {
        })
        messageStorage?.fetchMessagesFromDiscussion(recipient: (discussion?.recipient)!, completionHandler: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let messages):
                strongSelf.messages = messages
            }
        })
        userTextView.endEditing(true)
        messagesTableView.reloadData()
        scrollToLastCell()
        userTextView.text = ""
    }
    
    private func scrollToLastCell() {
        let lastRow = messagesTableView.numberOfRows(inSection: 0) - 1
        guard lastRow > 0 else {return}
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        messagesTableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    private func configureTableView() {
        messagesTableView.register(cellType: SendingMessageTableViewCell.self)
        messagesTableView.register(cellType: ReceivedMessageTableViewCell.self)
        messagesTableView.rowHeight = UITableView.automaticDimension
        messagesTableView.estimatedRowHeight = 80
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sendMsgCell: SendingMessageTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let receivedMsgCell: ReceivedMessageTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if messages[indexPath.row].isReceiving == true {
            let dummyMsg = messages[indexPath.row]
            dummyMsg.isRead = true
            receivedMsgCell.configure(message: dummyMsg)
            return receivedMsgCell
        } else {
            let msg = messages[indexPath.row]
            sendMsgCell.configure(message: msg)
            return sendMsgCell
        }
    }
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
