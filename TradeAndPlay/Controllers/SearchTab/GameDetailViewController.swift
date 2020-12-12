//
//  GameDetailViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var gameDetailTableView: UITableView!
    
    var dataStorage: DataStorage?
    var game: GameModel?
    private var pickerIndex: Int?
    private let ratingStarsImages: [UIImage?] = [UIImage(named: "etoile1"), UIImage(named: "etoile2"), UIImage(named: "etoile3"), UIImage(named: "etoile4"), UIImage(named: "etoile5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    private func configureTableView() {
        gameDetailTableView.sectionHeaderHeight = 70
        gameDetailTableView.estimatedRowHeight = 44.0
        gameDetailTableView.rowHeight = UITableView.automaticDimension
        gameDetailTableView.register(cellType: GameDetailPresentationTableViewCell.self)
        gameDetailTableView.register(cellType: SummaryTableViewCell.self)
        gameDetailTableView.register(cellType: ScreenShotsTableViewCell.self)
        gameDetailTableView.register(cellType: PlatformsTableViewCell.self)
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
        return 5
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
            header.headerLabel.text = "Select a platform"
            return header
        case 4:
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
            screenCell.screenShotCollectionView.delegate = self
            screenCell.screenShotCollectionView.dataSource = self
            screenCell.screenShotCollectionView.register(cellType: ScreenshotCollectionViewCell.self)
            screenCell.screenShotCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            return screenCell
            
        case 2:
            let sumCell: SummaryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            sumCell.configure(withModel: game)
            return sumCell
            
        case 3:
            let platCell: PlatformsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            platCell.platformsPickerView.delegate = self
            platCell.platformsPickerView.dataSource = self
            platCell.platformsPickerView.setValue(UIColor(named: "DarkBlue"), forKey: "textColor")
            return platCell
            
        case 4:
            let addCell: AddGameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            addCell.didTapAdd = { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.game?.isOwned = true
                strongSelf.dataStorage?.addToLibrary(game: game, index: strongSelf.pickerIndex ?? 0, completionHandler: {
                    strongSelf.displayAlert(title: "Done!", message: "This game has been added to your library.")
                })
            }
            addCell.didTapSeeWho = {
                
            }
            return addCell
        default:
            return UITableViewCell()
        }
    }
}

extension GameDetailViewController: UICollectionViewDelegate {
    
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

extension GameDetailViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerIndex = row
    }
}

extension GameDetailViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return game?.platforms?[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return game?.platforms?.count ?? 0
    }
}
