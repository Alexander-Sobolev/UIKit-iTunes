//
//  AlbumViewController.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 12.10.2021.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameAlbum: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Name Album"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameGroup: UILabel = {
        let label = UILabel()
        label.text = "Name Group"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let albumDate: UILabel = {
        let label = UILabel()
        label.text = "Album Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countTracks: UILabel = {
        let label = UILabel()
        label.text = "Count Tracks"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setItems()
       
    }
      
//MARK: - CollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Identifier", for: indexPath) as! AlbumCollectionViewCell
        cell.nameSong.text = "Count Tracks"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 20)
    }
}
//MARK: - SetConstraints

extension AlbumViewController {
    
    private func setItems() {
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 150),
            logo.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        view.addSubview(nameAlbum)
        NSLayoutConstraint.activate([
            nameAlbum.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            nameAlbum.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(nameGroup)
        NSLayoutConstraint.activate([
            nameGroup.topAnchor.constraint(equalTo: nameAlbum.bottomAnchor, constant: 20),
            nameGroup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(albumDate)
        NSLayoutConstraint.activate([
            albumDate.topAnchor.constraint(equalTo: nameGroup.bottomAnchor, constant: 20),
            albumDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(countTracks)
        NSLayoutConstraint.activate([
            countTracks.topAnchor.constraint(equalTo: albumDate.bottomAnchor, constant: 20),
            countTracks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            collectionView.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
