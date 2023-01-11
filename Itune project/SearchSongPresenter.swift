//
//  SearchSongPresenter.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 05.01.2023.
//

import UIKit

class SearchSongPresenter {
    
    weak var searchSongViewDelegate : SearchViewDelegate?
    private let networkService: NetworkService
    private let localDataService: LocalDataService
    
    init(networkService: NetworkService, localDataService: LocalDataService){
        self.networkService = networkService
        self.localDataService = localDataService
    }
    
    func makeSearch(song: String) {
        networkService.getSongList(for: song) { result in
            switch result {
            case .success(let success):
                let songs = success.results.compactMap { res in
                    SongObject(song: res)
                }
                self.searchSongViewDelegate?.showSearchResult(result: songs)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    func loadImage(from url: URL,
                   completion: @escaping (Result<Data, Error>) -> Void) {
        
        if let data = localDataService.getImage(url: url.absoluteString) {
            completion(.success(data))
            return
        }
        networkService.loadImage(from: url) { result in
            switch result {
            case .success(let success):
                if let data = try? Data(contentsOf: success) {
                    self.localDataService.saveImage(name: url.absoluteString, image: data)
                    completion(.success(data))
                } else {
                    completion(.failure(NetworkService.NetworkError.badData))
                }
                return
            case .failure(let failure):
                completion(.failure(failure))
                return
            }
        }
    }
}
