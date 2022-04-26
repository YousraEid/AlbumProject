//
//  usersViewModel.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation
import RxSwift

class UsersViewModel {
    var users : [user] = []
    func fetchUsers()->Completable{
        return .create { observer in
            AlbumsNetWorkManager.shared.getUser().subscribe { user in
                self.users = user
                observer(.completed)
                } onFailure: { Error in
                    observer(.error(Error))
                }
    }

}
}
