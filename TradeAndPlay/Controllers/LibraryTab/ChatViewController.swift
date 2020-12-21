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
    
    var messages: [String] = []
    var messageStorage: MessageStorage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messagesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        configureTableView()
    }
    
    @IBAction func sendButtonTaped(_ sender: Any) {
        sendMessage()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func sendMessage() {
        let content: String = userTextView.text
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { print("trimming")
            return
        }
        messageStorage?.addMessage(content: content, date: Date(), completionHandler: {
            
        })
        userTextView.endEditing(true)
        messagesTableView.reloadData()
        scrollToLastCell()
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
        messagesTableView.tableFooterView = UIView()
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
        
       // if messages[indexPath.row].isReceiving == true {
          //  let dummyMsg = messages[indexPath.row]
           // receivedMsgCell.configure(message: dummyMsg)
            return receivedMsgCell
        //} else {
           // let msg = messages[indexPath.row]
           // sendMsgCell.configure(message: msg)
            return sendMsgCell
       // }
    }
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
