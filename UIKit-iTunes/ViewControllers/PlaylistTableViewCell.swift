//
//  PlaylistTableViewCell.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 12.10.2021.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
   
    private let logo: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameAlbum: UILabel = {
       let label = UILabel()
        label.text = "Name album"
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameGroup: UILabel = {
        let label = UILabel()
         label.text = "Name group"
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let countTracks: UILabel = {
        let label = UILabel()
         label.text = "Count Tracks"
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setItems() {
        
        self.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            logo.heightAnchor.constraint(equalToConstant: 75),
            logo.widthAnchor.constraint(equalToConstant: 75)
            
        ])
        
        self.addSubview(nameAlbum)
        NSLayoutConstraint.activate([
            nameAlbum.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            nameAlbum.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameAlbum.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10)
            
        ])
        
        self.addSubview(nameGroup)
        NSLayoutConstraint.activate([
            nameGroup.topAnchor.constraint(equalTo: nameAlbum.bottomAnchor, constant: 10),
            nameGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameGroup.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10)
    
        ])
        
        self.addSubview(countTracks)
        NSLayoutConstraint.activate([
            countTracks.topAnchor.constraint(equalTo: nameGroup.bottomAnchor, constant: 10),
            countTracks.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            countTracks.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10)
            
        ])
    }
    
    func configureAlbum(album: Songs) {
        
        if let urlString = album.artworkUrl100 {
            Request.shared.requestData(url: urlString) { result in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        self.logo.image = image
                    case .failure(let error):
                        self.logo.image = nil
                        print("Not found" + error.localizedDescription)
                }
            }
        } else {
            logo.image = nil
        }
        nameAlbum.text = album.collectionName
        nameGroup.text = album.artistName
        countTracks.text = "\(album.trackCount) tracks"
}
}
