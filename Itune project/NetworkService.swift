//
//  NetworkService.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 07.01.2023.
//

import Foundation

class NetworkService {
    
    enum NetworkError: Error {
        case badUrl
        case badResponse
        case badServiceCode(code: Int)
        case badData
    }

    private func createUrl(for songName: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: songName),
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "country", value: "RU")
        ]

        return urlComponents.url
    }

    func getSongList(for songName: String, completion: @escaping (Result<ItunesResult, Error>) -> Void) {
        guard let url = createUrl(for: songName) else {
            completion(.failure(NetworkError.badUrl))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badResponse))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.badServiceCode(code: response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }

            do {
                let songs = try JSONDecoder().decode(ItunesResult.self, from: data)
                completion(.success(songs))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }

    let queue = DispatchQueue(label: "DownloadImageQueue")

    func loadImage(from url: URL,
                   completion: @escaping (Result<URL, Error>) -> Void) {
        let downloadTask = URLSession.shared.downloadTask(with: url) { url, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badResponse))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.badServiceCode(code: response.statusCode)))
                return
            }

            guard let url = url else {
                completion(.failure(NetworkError.badData))
                return
            }

            completion(.success(url))
        }

        queue.async {
            downloadTask.resume()
        }
    }
}

