//
//  GameDetailViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import UIKit
import IGDB_SWIFT_API

class GameDetailViewController: UIViewController {
    
    var game: Proto_Game?
    private var platforms: [Proto_Platform] = []
    private var screenshots: [Proto_Screenshot] = []
    private let ratingStarsImages: [UIImage?] = [UIImage(named: "etoile1"), UIImage(named: "etoile2"), UIImage(named: "etoile3"), UIImage(named: "etoile4"), UIImage(named: "etoile5")]
    
    @IBOutlet weak var gameDetailView: GameDetailView!
    @IBOutlet weak var gameDetailScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameDetails()
        gameDetailView.platformsPickerView.delegate = self
        gameDetailView.platformsPickerView.dataSource = self
        gameDetailView.screenshotsCollectionView.delegate = self
        gameDetailView.screenshotsCollectionView.dataSource = self
        gameDetailView.platformsPickerView.setValue(UIColor.white, forKey: "textColor")
        platforms += game!.platforms
        screenshots += game!.screenshots
        configureCollectionView()
        print(screenshots.count)
        
    }
    
    private func configureCollectionView() {
        gameDetailView.screenshotsCollectionView.register(UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotCollectionViewCell")
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
    
    private func configureDate() -> String {
        guard let game = game else {return "Oups"}
        let date = Date(timeIntervalSince1970: TimeInterval(game.firstReleaseDate.seconds))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    private func setGameDetails() {
        guard let game = game else {return}
        let image_id = game.cover.imageID
        let imageURL = imageBuilder(imageID: image_id, size: .COVER_BIG, imageType: .PNG)
        gameDetailView.coverImageView.load(url: URL(string: imageURL)!)
        gameDetailView.nameLabel.text = game.name
        gameDetailView.storyLineLabel.text = game.summary
        gameDetailView.ratingsLabel.text = "Ratings: \(String(Int(round(game.rating))))/100"
        gameDetailView.releaseLabel.text = "Firest release: \(configureDate())"
        var genreNames = [String]()
        game.genres.forEach { genreNames.append($0.name) }
        gameDetailView.genreLabel.text = "Genres: \(genreNames.joined(separator: ", "))"
        gameDetailView.ratingStarsImageView.image = configureRatings(rating: game.rating)
    }
}

extension GameDetailViewController: UIPickerViewDelegate {
    
}

extension GameDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return platforms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return platforms[row].name
    }
}

extension GameDetailViewController: UICollectionViewDelegate {
    
}

extension GameDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        screenshots.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCollectionViewCell", for: indexPath) as? ScreenshotCollectionViewCell else {
            print("ca passe pas")
            return UICollectionViewCell()
        }
        
        let image_id = screenshots[indexPath.row].imageID
        let imageURL = imageBuilder(imageID: image_id, size: .COVER_BIG, imageType: .PNG)
        
        cell.screenshotImageView.load(url: URL(string: imageURL)!)
        
        return cell
    }
    
    
}
