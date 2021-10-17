//
//  Album.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 17.10.2021.
//

import Foundation

struct Album: Codable {
    let results: [Songs]
}

struct Songs: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String
    let collectionId: Int
}
