//
//  ProfileViewController.swift
//  GameAPI
//
//  Created by mac on 08/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImg.layer.cornerRadius = 75
        photoImg.layer.masksToBounds = true
    }

    @IBAction func fb(_ sender: UIButton) {
        let url = "https://facebook.com/tonisuwen"
        sosmedUrl(url: url)
    }
    
    @IBAction func ig(_ sender: UIButton) {
        let url = "https://instagram.com/tonisuwen"
        sosmedUrl(url: url)
    }
    
    @IBAction func yt(_ sender: UIButton) {
        let url = "https://youtube.com/tonisuwendi"
        sosmedUrl(url: url)
    }
    
    @IBAction func gh(_ sender: UIButton) {
        let url = "https://github.com/tonisuwendi"
        sosmedUrl(url: url)
    }
    
    func sosmedUrl(url: String) {
        if let url = NSURL(string: url) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
}
