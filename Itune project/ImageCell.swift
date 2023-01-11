//
//  ImageCell.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 05.01.2023.
//

import UIKit

class ImageCell: UITableViewCell {
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.accessoryType = .disclosureIndicator
        
        contentImageView.layer.cornerRadius = 10
        contentImageView.clipsToBounds = true
        
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        titleLabel.font = UIFont(name: "Helvetica", size: 18)
        subtitleLabel.font = UIFont(name: "Helvetica", size: 18)

        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentImageView.widthAnchor.constraint(equalToConstant: 100),
            contentImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor,constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 15),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
        contentView.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
