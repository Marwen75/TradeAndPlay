//
//  LibraryViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private var storedGames: [StoredGame]?
    var dataStorage: DataStorage?
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        libraryTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        dataStorage?.fetchGames(completionHandler: { result in
            switch result {
            case .failure(let error):
                self.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let games):
                self.storedGames = games
            }
        })
    }
    
    private func configureTableView() {
        libraryTableView.rowHeight = 570
        libraryTableView.sectionHeaderHeight = 60
        libraryTableView.register(cellType: LibraryTableViewCell.self)
    }
    
}

extension LibraryViewController: UITableViewDelegate {
    
}

extension LibraryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        switch section {
        case 0:
            header.headerLabel.text = "Your games"
            return header
        case 1:
            header.headerLabel.text = "Your research"
            return header
        case 2:
            header.headerLabel.text = "Your current trades"
            return header
        default:
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LibraryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.libraryCollectionView.delegate = self
        cell.libraryCollectionView.dataSource = self
        cell.libraryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell.libraryCollectionView.register(cellType: LibraryCollectionViewCell.self)
        return cell
    }
    
    
}

extension LibraryViewController: UICollectionViewDelegate {
    
}

extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storedGames?.count ?? 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LibraryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let storedGames = storedGames{
            cell.configure(whitStoredGame: storedGames[indexPath.row])
        }
        return cell
    }
        
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
}
