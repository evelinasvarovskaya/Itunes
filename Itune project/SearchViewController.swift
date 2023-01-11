//
//  SearchSongViewController.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 05.01.2023.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func showSearchResult(result: [SongObject])
}

class SearchViewController: UIViewController {
    
    private var songs: [SongObject]?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.rowHeight = 120
        return tableView
    }()
    
    private let searchController = UISearchController()
    
    private let presenter = SearchSongPresenter(networkService: NetworkService(), localDataService: LocalDataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.searchSongViewDelegate = self
        
        prepare()
        view.backgroundColor = UIColor.systemBackground
        title = "Search"
    }
    private func prepare() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search music"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

extension SearchViewController: SearchViewDelegate {
    func showSearchResult(result: [SongObject]) {
        songs = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        presenter.makeSearch(song: text)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let song = songs?[indexPath.row] {
            self.navigationController?.pushViewController(MoreAboutSongViewController(song: song), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell
        let songData = songs?[indexPath.row]
        cell?.titleLabel.text = songData?.song.trackName
        cell?.subtitleLabel.text = songData?.song.artistName
        if let image = songs?[indexPath.row].image {
            cell?.contentImageView.image = image
        } else {
            if let url = URL(string: songData?.song.artworkUrl100 ?? "") {
                presenter.loadImage(from: url) { dataResult in
                    switch dataResult {
                    case .success(let success):
                        let loadedImage = UIImage(data: success)
                        DispatchQueue.main.async {
                            self.songs?[indexPath.row].image = loadedImage
                            cell?.contentImageView.image = loadedImage
                            tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
        return cell!
    }
}
