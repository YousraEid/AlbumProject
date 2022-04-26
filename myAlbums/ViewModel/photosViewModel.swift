//
//  photosViewmodel.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation
import RxSwift
class PhotosViewModel {
    var photos : [photo] = []
    func getPhotos (with id : Int)-> Completable {
        return .create { observer in
            AlbumsNetWorkManager.shared.getPhotos(with: id).subscribe{ photo in
                self.photos = photo
                observer(.completed)
                } onFailure: { Error in
                    observer(.error(Error))
                }
        }
    }
}
