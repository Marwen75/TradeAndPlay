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
        setGameDetails()
        configureTableView()
        configureCollectionView()
    }
    
    private func configureTableView() {
        gameDetailTableView.estimatedRowHeight = 44.0
        gameDetailTableView.rowHeight = UITableView.automaticDimension
        gameDetailTableView.register(UINib(nibName: "GameDetailPresentationTableViewCell", bundle: nil), forCellReuseIdentifier: "GameDetailPresentationTableViewCell")
        gameDetailTableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        gameDetailTableView.register(UINib(nibName: "ScreenShotsTableViewCell", bundle: nil), forCellReuseIdentifier: "ScreenShotsTableViewCell")
        gameDetailTableView.register(UINib(nibName: "PlatformsTableViewCell", bundle: nil), forCellReuseIdentifier: "PlatformsTableViewCell")
    }
    
    private func configureCollectionView() {
        //screenshotCollectionView.register(UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotCollectionViewCell")
    }
    
    private func configureRatings(rating: Double) -> UIImage {
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
    
    /*private func configureDate() -> String {
     guard let game = game else {return "Oups"}
     let date = Date(timeIntervalSince1970: TimeInterval(game.first_release_date))
     let dateFormatter = DateFormatter()
     dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
     dateFormatter.locale = NSLocale.current
     dateFormatter.dateFormat = "yyyy-MM-dd"
     let strDate = dateFormatter.string(from: date)
     return strDate
     }*/
    
    private func setGameDetails() {
        guard let game = game else {return}
        let image_id = game.cover?.image_id
        let imageURL = "\(ApiKey.imageUrl)\(image_id ?? "coluje").png"
        //coverImageView.load(url: URL(string: imageURL)!)
        //gameDetailView.nameLabel.text = game.name
        //summaryLabel.text = game.summary
        //ratingsLabel.text = "Ratings: \(String(Int(round(game.rating ?? 0))))/100"
        //gameDetailView.releaseLabel.text = "Firest release: \(configureDate())"
        //var genreNames = [String]()
        // game.genres?.forEach { genreNames.append($0.name) }
        // genreLabel.text = "Genres: \(genreNames.joined(separator: ", "))"
        //ratingsImageView.image = configureRatings(rating: game.rating ?? 0)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let presCell = tableView.dequeueReusableCell(withIdentifier: "GameDetailPresentationTableViewCell", for: indexPath) as? GameDetailPresentationTableViewCell else {
                return UITableViewCell()
            }
            
            let imgId = game?.cover?.image_id
            
            presCell.coverImageView.load(url: URL(string: "\(ApiKey.imageUrl)\(imgId ?? "coluje").png")!)
            
            var genreNames = [String]()
            game?.genres?.forEach { genreNames.append($0.name) }
            presCell.configure(title: game?.name ?? "", genres: genreNames.joined(separator: ", "), release: "", ratings: String(game?.rating ?? 1))
            return presCell
        } else if indexPath.section == 1 {
            guard let sumCell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            sumCell.configure(summary: game?.summary ?? "N/A")
            return sumCell
            
        } else if indexPath.section == 2 {
            guard let screenCell = tableView.dequeueReusableCell(withIdentifier: "ScreenShotsTableViewCell", for: indexPath) as? ScreenShotsTableViewCell else {
                return UITableViewCell()
            }
            screenCell.screenShotCollectionView.delegate = self
            screenCell.screenShotCollectionView.dataSource = self
            screenCell.screenShotCollectionView.register(UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotCollectionViewCell")
            return screenCell
        } else {
            guard let platCell = tableView.dequeueReusableCell(withIdentifier: "PlatformsTableViewCell", for: indexPath) as? PlatformsTableViewCell else {
                return UITableViewCell()
            }
            return platCell
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCollectionViewCell", for: indexPath) as? ScreenshotCollectionViewCell else {
            print("ca passe pas")
            return UICollectionViewCell()
        }
        
        let imageId = game?.screenshots?[indexPath.row].image_id ?? ""
        let imageURL = "\(ApiKey.imageUrl)\(imageId).png"
        
        cell.screenshotImageView.load(url: URL(string: imageURL)!)
        
        return cell
    }
    
    
}
