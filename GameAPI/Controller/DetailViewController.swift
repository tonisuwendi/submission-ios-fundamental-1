//
//  DetailViewController.swift
//  GameAPI
//
//  Created by mac on 08/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var photoGame: UIImageView!
    @IBOutlet weak var ratingGame: UILabel!
    @IBOutlet weak var ratingTop: UILabel!
    @IBOutlet weak var releasedGame: UILabel!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var descGame: UILabel!
    @IBOutlet weak var gotoWeb: UIButton!
    
    var games: Game?
    var websiteURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoGame.layer.cornerRadius = 15
        
        if let result = games {
            let idGame = result.id
            getDetailGameData(id: idGame)
            nameGame.text = result.name
            guard let photogame = result.backgroundImage else { return }
            guard let photoImageURL = URL(string: photogame) else {return}
            getImageData(url: photoImageURL)
            ratingGame.text = String(result.rating)
            switch result.ratingTop {
                case 1:
                    ratingTop.text = String("★")
                    break
                case 2:
                    ratingTop.text = String("★")
                    break
                case 3:
                    ratingTop.text = String("★★★")
                    break
                case 4:
                    ratingTop.text = String("★★★★")
                    break
                case 5:
                    self.ratingTop.text = String("★★★★★")
                default:
                    self.ratingTop.text = String("")
            }
            releasedGame.text = "Rilis: \(convertDateFormatter(result.released))"
        }
                
    }
    
    func getDetailGameData(id: Int) {
        APIService().detailGame(id: id) { (result) in
            self.developer.text = result.developers[0].name
            self.ratingCount.text = String(result.ratingsCount) + " Ratings"
            self.descGame.text = result.description
            self.websiteURL = result.website
        }
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

    @IBAction func toWebsite(_ sender: AnyObject) {
        if self.websiteURL != "" {
            if let url = NSURL(string: self.websiteURL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }else {
            let alert = UIAlertController(title: "Gagal membuka website", message: "Game ini belum mempunyai website", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
