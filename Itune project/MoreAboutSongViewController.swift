//
//  MoreAboutSongViewController.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 09.01.2023.
//

import UIKit

class MoreAboutSongViewController: UIViewController {
    
    let song: SongObject
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let typeTitle = UILabel()
    let typeSubtitle = UILabel()
    let collectionTitle = UILabel()
    let collectionSubtitle = UILabel()
    let artistTitle = UILabel()
    let artistSubtitle = UILabel()
    
    
    init(song: SongObject) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
        addTitle()
        addSubtitle()
        addType()
        addCollection()
        if let price = song.song.trackPrice, let currency = song.song.currency {
            addPrice(price: price, currency: currency)
        }
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func addImage() {

        imageView.image = song.image
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func addTitle() {
        let label = titleLabel
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        label.text = song.song.trackName
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.topAnchor),
            label.heightAnchor.constraint(equalToConstant: 44),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    private func addSubtitle() {
        subtitleLabel.font = UIFont(name: "Helvetica-Bold", size: 24)
        subtitleLabel.text = song.song.artistName
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 50),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    private func addType() {
        typeTitle.font = UIFont(name: "Helvetica-Bold", size: 18)
        typeSubtitle.font = UIFont(name: "Helvetica", size: 18)
        typeTitle.text = "Жанр"
        typeSubtitle.text = song.song.primaryGenreName
        view.addSubview(typeTitle)
        view.addSubview(typeSubtitle)
        typeTitle.translatesAutoresizingMaskIntoConstraints = false
        typeSubtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            typeTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            typeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            typeSubtitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            typeSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            typeSubtitle.topAnchor.constraint(equalTo: typeTitle.bottomAnchor, constant: 4)
        ])
    }
    private func addCollection() {
        collectionTitle.font = UIFont(name: "Helvetica-Bold", size: 18)
        collectionSubtitle.font = UIFont(name: "Helvetica", size: 18)
        collectionTitle.text = "Альбом"
        collectionSubtitle.text = song.song.collectionName
        view.addSubview(collectionTitle)
        view.addSubview(collectionSubtitle)
        collectionTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionSubtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionTitle.topAnchor.constraint(equalTo: typeSubtitle.bottomAnchor, constant: 16),
            collectionTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            collectionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionSubtitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            collectionSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionSubtitle.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 4)
        ])
    }
    private func addPrice(price: Double, currency: Currency) {
        artistTitle.font = UIFont(name: "Helvetica-Bold", size: 18)
        artistSubtitle.font = UIFont(name: "Helvetica", size: 18)
        artistTitle.text = "Цена"
        artistSubtitle.text = "\(price) \(currency)".uppercased()
        view.addSubview(artistTitle)
        view.addSubview(artistSubtitle)
        artistTitle.translatesAutoresizingMaskIntoConstraints = false
        artistSubtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistTitle.topAnchor.constraint(equalTo: collectionSubtitle.bottomAnchor, constant: 16),
            artistTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            artistTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            artistSubtitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            artistSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            artistSubtitle.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 4)
        ])
    }
}
