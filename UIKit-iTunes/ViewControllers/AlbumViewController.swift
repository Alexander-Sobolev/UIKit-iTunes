//
//  AlbumViewController.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 12.10.2021.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var album: Songs?
    var song = [Song]()
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "Identifier1")
        setItems()
        setupModel()
        fetchPlaylist(album: album)
    }
    
    private func setupModel() {
        
        guard let album = album else { return }
        
        nameAlbum.text = album.collectionName
        nameGroup.text = album.artistName
        albumDate.text = setupDate(date: album.releaseDate)
        countTracks.text = "\(album.trackCount) tracks:"
        
        guard let url = album.artworkUrl100 else { return }
        setupImage(urlString: url)
    }
    
    
    private func setupDate(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
    
    private func setupImage(urlString: String?) {
        if let url = urlString {
            Request.shared.requestData(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.logo.image = image
                case .failure(let error):
                    self?.logo.image = nil
                    print("No album logo" + error.localizedDescription)
                }
            }
        } else {
            logo.image = nil
        }
    }
    
    private func fetchPlaylist(album: Songs?) {
        
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        DataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songModel, error in
            if error == nil {
                guard let songModel = songModel  else { return }
                self?.song = songModel.results
                self?.collectionView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
      
//MARK: - CollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        song.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Identifier1", for: indexPath) as! AlbumCollectionViewCell
        let song = song[indexPath.row].trackName
        cell.nameTracks.text = song 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 130, height: 30)
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
            nameAlbum.widthAnchor.constraint(equalToConstant: 150)
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
