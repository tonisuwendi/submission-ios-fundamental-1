//
//  ViewController.swift
//  GameAPI
//
//  Created by mac on 07/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGetGames()
        
        gameTableView.delegate = self
        
        searchBar.delegate = self
        
        gameTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func loadGetGames() {
        viewModel.fetchGameData { [weak self] in
            self?.gameTableView.dataSource = self
            self?.gameTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.seacrhGame(search: searchText) { [weak self] in
            self?.gameTableView.dataSource = self
            self?.gameTableView.reloadData()
        }
    }

}

extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        
        let games = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(games)
        
        return cell
    }
    
}

extension GameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detail.games = viewModel.cellForRowAt(indexPath: indexPath)
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
