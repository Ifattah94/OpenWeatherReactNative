//
//  AnimeListVC.swift
//  topAnimePractice
//
//  Created by C4Q on 10/8/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class AnimeListVC: UIViewController {

    lazy var animeTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .green
    
        return tv
    }()
    
    lazy var searchBar: UISearchBar = {
      let sb = UISearchBar()
        sb.barStyle = .default
        sb.delegate = self
        return sb
    }()
    
    private var animeList = [Anime]() {
        didSet {
            animeTableView.reloadData()
        }
    }
    
    private var searchWord: String? {
        didSet {
            animeTableView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "AnimeCell", bundle: nil)
    
                animeTableView.register(nib, forCellReuseIdentifier: "AnimeCell")
        animeTableView.dataSource = self
        animeTableView.delegate = self
        setupSearchBar()
       setupAnimeTableView()
       
       
        // Do any additional setup after loading the view.
    }
    
    
    private func loadData() {
        AnimeAPIClient.shared.getAnimeFrom(searchWord: searchWord ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let animeFromOnline):
                    self.animeList = animeFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        searchBar.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.23).isActive = true
        
    }
    
    private func setupAnimeTableView() {
        view.addSubview(animeTableView)
        animeTableView.translatesAutoresizingMaskIntoConstraints = false
        animeTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        animeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    

}

extension AnimeListVC: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let anime = animeList[indexPath.row]
        let detailVC = AnimeDetailVC()
        detailVC.anime = anime
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

extension AnimeListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWord = searchText
        loadData()
    }
}
