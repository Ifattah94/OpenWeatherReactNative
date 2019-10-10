//
//  FavoritesVC.swift
//  topAnimePractice
//
//  Created by C4Q on 10/8/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    
    lazy var favoritesTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .green
    
        return tv
    }()
    
    private var animeList = [Anime]() {
        didSet {
            favoritesTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "AnimeCell", bundle: nil)
           
                       favoritesTableView.register(nib, forCellReuseIdentifier: "AnimeCell")
        favoritesTableView.dataSource = self
               favoritesTableView.delegate = self
        loadFaves()
        setupTableView()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFaves()
    }
    

    private func loadFaves() {
        do {
            self.animeList = try AnimePersistenceManager.manager.getAnime()
        } catch {
            print(error)
        }
    }
    
    
    
    private func setupTableView() {
        view.addSubview(favoritesTableView)
               favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
               favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
               favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
               favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
   
}



extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
         let anime = animeList[indexPath.row]
         cell.titleLabel.text = anime.title
         cell.scoreLabel.text = anime.score.description
         cell.selectionStyle = .none
         
         if let image = ImageHelper.shared.image(forKey: anime.imageUrl as NSString) {
        cell.animeImageView.image = image
             
         } else {
             ImageHelper.shared.getImage(urlStr: anime.imageUrl) { (result) in
                 DispatchQueue.main.async {
                     switch result {
                     case .failure(let error):
                         print(error)
                     case .success(let imageFromOnline):
                         cell.animeImageView.image = imageFromOnline
                     }
                 }
             }
         }
         return cell
    }
    
    
}
