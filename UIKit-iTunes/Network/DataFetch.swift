//
//  DataFetch.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 17.10.2021.
//

import Foundation

class DataFetch {
    
    static let shared = DataFetch()
    private init() {}
    
    func fetchAlbums(url: String, responce: @escaping (Album?, Error?) -> Void) {
        Request.shared.requestData(url: url) { result in
            switch result {
            
            case .success(let data):
                do {
                    let songs = try JSONDecoder().decode(Album.self, from: data)
                    responce(songs, nil)
                } catch let error {
                    print("Error:\(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                responce(nil, error)
               
            }
        }
    }
    
    func fetchSongs(urlString: String, responce: @escaping (SongModel?, Error?) -> Void) {
        Request.shared.requestData(url: urlString) { result in
            switch result {
            
            case .success(let data):
                do {
                    let devices = try JSONDecoder().decode(SongModel.self, from: data)
                    responce(devices, nil)
                } catch let error {
                    print("Error:\(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
                responce(nil, error)
               
            }
        }
    }
}
