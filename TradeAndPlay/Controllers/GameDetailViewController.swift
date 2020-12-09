//
//  GameDetailViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    var game: Game?
    private let ratingStarsImages: [UIImage?] = [UIImage(named: "etoile1"), UIImage(named: "etoile2"), UIImage(named: "etoile3"), UIImage(named: "etoile4"), UIImage(named: "etoile5")]
    
    @IBOutlet weak var gameDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        gameDetailTableView.estimatedRowHeight = 44.0
        gameDetailTableView.rowHeight = UITableView.automaticDimension
        gameDetailTableView.register(UINib(nibName: GameDetailPresentationTableViewCell.id, bundle: nil), forCellReuseIdentifier: GameDetailPresentationTableViewCell.id)
        gameDetailTableView.register(UINib(nibName: SummaryTableViewCell.id, bundle: nil), forCellReuseIdentifier: SummaryTableViewCell.id)
        gameDetailTableView.register(UINib(nibName: ScreenShotsTableViewCell.id, bundle: nil), forCellReuseIdentifier: ScreenShotsTableViewCell.id)
        gameDetailTableView.register(UINib(nibName: PlatformsTableViewCell.id, bundle: nil), forCellReuseIdentifier: PlatformsTableViewCell.id)
        gameDetailTableView.register(UINib(nibName: AddGameTableViewCell.id, bundle: nil), forCellReuseIdentifier: AddGameTableViewCell.id)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let game = game else {return UITableViewCell()}
        switch indexPath.section {
        case 0:
            
            guard let presCell = tableView.dequeueReusableCell(withIdentifier: GameDetailPresentationTableViewCell.id, for: indexPath) as? GameDetailPresentationTableViewCell else {
                return UITableViewCell()
            }
            let imgId = game.cover?.image_id
            presCell.coverImageView.load(url: URL(string: "\(ApiKey.imageUrl)\(imgId ?? "coluje").png")!)
            var genreNames = [String]()
            game.genres?.forEach { genreNames.append($0.name) }
            presCell.configure(title: game.name, genres: genreNames.joined(separator: ", "), release: configureDate(game: game), ratings: configureRatings(game: game))
            presCell.ratingsImageView.image = configureRatingsImage(rating: game.rating ?? 0)
            return presCell
            
        case 1:
            guard let screenCell = tableView.dequeueReusableCell(withIdentifier: ScreenShotsTableViewCell.id, for: indexPath) as? ScreenShotsTableViewCell else {
                return UITableViewCell()
            }
            screenCell.screenShotCollectionView.delegate = self
            screenCell.screenShotCollectionView.dataSource = self
            screenCell.screenShotCollectionView.register(UINib(nibName: ScreenshotCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: ScreenshotCollectionViewCell.id)
            return screenCell
            
        case 2:
            guard let sumCell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.id, for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            sumCell.configure(summary: game.summary ?? "N/A")
            return sumCell
            
        case 3:
            guard let platCell = tableView.dequeueReusableCell(withIdentifier: PlatformsTableViewCell.id, for: indexPath) as? PlatformsTableViewCell else {
                return UITableViewCell()
            }
            platCell.platformPickerView.delegate = self
            platCell.platformPickerView.dataSource = self
            return platCell
            
        case 4:
            guard let addCell = tableView.dequeueReusableCell(withIdentifier: AddGameTableViewCell.id, for: indexPath) as? AddGameTableViewCell else {
                return UITableViewCell()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.id, for: indexPath) as? ScreenshotCollectionViewCell else {
            print("ca passe pas")
            return UICollectionViewCell()
        }
        let imageId = game?.screenshots?[indexPath.row].image_id ?? ""
        let imageURL = "\(ApiKey.imageUrl)\(imageId).png"
        cell.screenshotImageView.load(url: URL(string: imageURL)!)
        return cell
    }
}

extension GameDetailViewController: UIPickerViewDelegate {

}

extension GameDetailViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return game?.platforms?[row].name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return game?.platforms?.count ?? 0
    }
}
