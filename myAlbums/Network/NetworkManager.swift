//
//  NetworkManager.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import RxSwift
import Moya
import RxMoya

struct AlbumsNetWorkManager {
     static let shared = AlbumsNetWorkManager()
    private let provider = MoyaProvider<FourmService>()

    private init(){}

    func getUser()->Single<[user]>{
        return provider.rx                             // we use the Reactive component for our provider
            .request(.getUser)                         // we specify the call
                 .filterSuccessfulStatusAndRedirectCodes()   // we tell it to only complete the call if the operation is successful, otherwise it will give us an error
                 .map([user].self)                       // we map the response to our Codable objects

    }

    func getAlbum(with id : Int)->Single<[album]>{
        return provider.rx
            .request(.getAlbum(userId: id))
            .filterSuccessfulStatusAndRedirectCodes()
            .map([album].self)
    }

    func getPhotos(with id : Int)->Single<[photo]>{
        return provider.rx
            .request(.getPhotos(albumId: id))
            .filterSuccessfulStatusAndRedirectCodes()
            .map([photo].self)
    }

 }
