//
//  AlbumCollectionViewCell.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 13.10.2021.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    let nameTracks: UILabel = {
       let label = UILabel()
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setConstraints() {
        
        self.addSubview(nameTracks)
        NSLayoutConstraint.activate([
            nameTracks.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameTracks.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            nameTracks.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nameTracks.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
