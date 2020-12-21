//
//  GameDetailViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var gameDetailTableView: UITableView!
    
    static let segueId = "gameToPlayer"
    var gameStorage: GameStorage?
    var dummyUserStorage: UserStorage?
    var game: GameModel?
    var players: [User]?
    private let ratingStarsImages: [UIImage?] = [UIImage(named: "etoile1"), UIImage(named: "etoile2"), UIImage(named: "etoile3"), UIImage(named: "etoile4"), UIImage(named: "etoile5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        print(game?.cover)
        print(game?.name)
        print(game?.platform)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GameDetailViewController.segueId {
            let playerVC = segue.destination as! PlayerViewController
            playerVC.players = players
        }
    }
    
    private func configureTableView() {
        gameDetailTableView.sectionHeaderHeight = 70
        gameDetailTableView.estimatedRowHeight = 44.0
        gameDetailTableView.rowHeight = UITableView.automaticDimension
        gameDetailTableView.register(cellType: GameDetailPresentationTableViewCell.self)
        gameDetailTableView.register(cellType: SummaryTableViewCell.self)
        gameDetailTableView.register(cellType: ScreenShotsTableViewCell.self)
        gameDetailTableView.register(cellType: AddGameTableViewCell.self)
    }
    
    private func configureRatingsImage(rating: Double) -> UIImage {
        if rating <= 20 {
            return ratingStarsImages[0]!
        } else if rating > 20 && rating < 40 {
            return ratingStarsImages[1]!
        } else if rating > 40 && rating < 70 {
            return ratingStarsImages[2]!
        } else if rating > 70 && rating < 85 {
            return ratingStarsImages[3]!
        } else {
            return ratingStarsImages[4]!
        }
    }
}

extension GameDetailViewController: UITableViewDelegate {
    
}

extension GameDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        switch section {
        case 0:
            header.headerLabel.text = game?.name
            return header
        case 1:
            header.headerLabel.text = "Screenshots"
            return header
        case 2:
            header.headerLabel.text = "Summary"
            return header
        case 3:
            header.headerLabel.text = "What to do next ?"
            return header
        default:
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let game = game else {return UITableViewCell()}
        switch indexPath.section {
        case 0:
            let presCell: GameDetailPresentationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let imgId = game.cover
            presCell.coverImageView.load(url: URL(string: "\(ApiConfig.imageUrl)\(imgId ).png")!)
            presCell.configure(withModel: game)
            presCell.ratingsImageView.image = configureRatingsImage(rating: game.rating )
            return presCell
            
        case 1:
            let screenCell: ScreenShotsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            screenCell.screenShotCollectionView.dataSource = self
            screenCell.screenShotCollectionView.register(cellType: ScreenshotCollectionViewCell.self)
            screenCell.screenShotCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            return screenCell
            
        case 2:
            let sumCell: SummaryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            sumCell.configure(withModel: game)
            return sumCell
            
        case 3:
            let addCell: AddGameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            addCell.didTapAdd = { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.gameStorage?.addToOwnedList(game: game, platform: game.platform, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
                    case .success(let name):
                        strongSelf.displayAlert(title: "Done!", message: "\(name) has been added to your Owned list.")
                    }
                })
            }
            addCell.didTapSeeWho = { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.dummyUserStorage?.fetchUsersWhoHasGame(named: game.name, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
                    case .success(let users):
                        strongSelf.players = users
                        strongSelf.performSegue(withIdentifier: GameDetailViewController.segueId, sender: nil)
                    }
                })
            }
            addCell.didTapAddToSearch = { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.gameStorage?.addToSearchList(game: game, platform: game.platform, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
                    case .success(let gameName):
                        strongSelf.displayAlert(title: "Done!", message: "\(gameName) has been added to your Search list.")
                    }
                })
            }
            return addCell
        default:
            return UITableViewCell()
        }
    }
}

extension GameDetailViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        game?.screenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ScreenshotCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let gameModel = game {
            let imageId = gameModel.screenshots?[indexPath.row] ?? ""
            if let imageURL = URL(string: String("\(ApiConfig.imageUrl)\(imageId).png")) {
                cell.screenshotImageView.load(url: imageURL)
            }
        }
        return cell
    }
}
