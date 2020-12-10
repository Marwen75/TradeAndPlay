//
//  LibraryViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private var games: [StoredGame] = []
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        libraryTableView.rowHeight = 300
        libraryTableView.sectionHeaderHeight = 60
    }
    
    private func configureTableView() {
        libraryTableView.register(UINib(nibName: LibraryTableViewCell.id, bundle: nil), forCellReuseIdentifier: LibraryTableViewCell.id)
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
            header.headerLabel.text = "Your trades"
            return header
        default:
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.id, for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        cell.libraryCollectionView.delegate = self
        cell.libraryCollectionView.dataSource = self
        cell.libraryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell.libraryCollectionView.register(UINib.init(nibName: LibraryCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: LibraryCollectionViewCell.id)
        return cell
    }
    
    
}

extension LibraryViewController: UICollectionViewDelegate {
    
}

extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.id, for: indexPath) as? LibraryCollectionViewCell else {
            return UICollectionViewCell()
        }
        //let imageId = game[indexPath.row].cover?.image_id ?? ""
        //let imageURL = "\(ApiKey.imageUrl)\(imageId).png"
        //cell.gameImageView.load(url: URL(string: imageURL)!)
        //cell.configure(platform: game[indexPath.row].name, name: "")
        return cell
    }
    
    
   /* func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        if (kind == UICollectionElementKindSectionHeader) {
            let section = indexPath.section
            switch (section) {
            case 1:
                let  firstheader: OfferHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OfferHeaderCell", for: indexPath) as! OfferHeaderCell
                reusableview = firstheader
            case 2:
                let  secondHeader: APRHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "APRHeaderCell", for: indexPath) as! APRHeaderCell
                reusableview = secondHeader
            default:
                return reusableview
                
            }
        }
        return reusableview
    }
} */
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
}
