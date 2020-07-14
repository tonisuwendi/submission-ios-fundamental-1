//
//  GameTableViewCell.swift
//  GameAPI
//
//  Created by mac on 07/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var photoGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var releasedGame: UILabel!
    @IBOutlet weak var ratingTop: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    
    func setCellWithValueOf(_ game: Game) {
        updateUI(nameGame: game.name, releasedGame: game.released, ratingTop: game.ratingTop, ratingGame: game.rating, photoGame: game.backgroundImage)
    }
    
    private func updateUI(nameGame: String?, releasedGame: String?, ratingTop: Int?, ratingGame: Double?, photoGame: String?) {
        
        self.nameGame.text = nameGame
        self.releasedGame.text = "Rilis: " + convertDateFormatter(releasedGame)
        guard let ratingtop = ratingTop else { return }
        switch ratingtop {
            case 1:
                self.ratingTop.text = String("★")
                break
            case 2:
                self.ratingTop.text = String("★")
                break
            case 3:
                self.ratingTop.text = String("★★★")
                break
            case 4:
                self.ratingTop.text = String("★★★★")
                break
            case 5:
                self.ratingTop.text = String("★★★★★")
            default:
                self.ratingTop.text = String("")
        }
        guard let ratinggame = ratingGame else { return }
        self.ratingGame.text = String(ratinggame)
        
        guard let photogame = photoGame else { return }
        
        guard let photoImageURL = URL(string: photogame) else {
            return
        }
        
        self.photoGame.layer.cornerRadius = 7
        
        getImageData(url: photoImageURL)
    }
    
    func getImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("datatask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("empty data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.photoGame.image = image
                }
            }
        }.resume()
    }
    
    func convertDateFormatter(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newData = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd-MM-yyyy"
                fixDate = dateFormatter.string(from: newData)
            }
        }
        return fixDate
    }
    
}
