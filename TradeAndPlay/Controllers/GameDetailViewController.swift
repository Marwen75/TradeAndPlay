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
    
    @IBOutlet weak var gameDetailView: GameDetailView!
    @IBOutlet weak var gameDetailScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameDetails()
        gameDetailView.platformsPickerView.delegate = self
        gameDetailView.platformsPickerView.dataSource = self
        gameDetailView.platformsPickerView.setValue(UIColor.white, forKey: "textColor")
        platforms += game!.platforms
        print(platforms[0].name)
    }
    
    private func setGameDetails() {
        guard let game = game else {
            print("rien")
            return
        }
        let image_id = game.cover.imageID
        let imageURL = imageBuilder(imageID: image_id, size: .COVER_BIG, imageType: .PNG)
        gameDetailView.coverImageView.load(url: URL(string: imageURL)!)
        gameDetailView.nameLabel.text = game.name
        gameDetailView.storyLineLabel.text = game.summary
        gameDetailView.ratingsLabel.text = String(game.rating)
        gameDetailView.genreLabel.text = game.genres.first?.name
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
