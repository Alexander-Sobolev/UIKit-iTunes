//
//  Songs.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 17.10.2021.
//

import Foundation

struct SongModel: Codable {
    let results: [Song]
}

struct Song: Codable {
    let trackName: String?
}
