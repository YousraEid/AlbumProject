//
//  albumsViewModel.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation
import RxSwift

class AlbumViewModel {
    var albums : [album] = []
    func getAlbum (with id : Int)-> Completable {
        return .create { observer in
            AlbumsNetWorkManager.shared.getAlbum(with: id).subscribe{ album in
                self.albums = album
                observer(.completed)
                } onFailure: { Error in
                    observer(.error(Error))
                }
        }
    }
}
