//
//  AlbumsModel.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation

struct album : Codable {
    var userId : Int
    var id : Int
    var title : String
}

struct albumDict : Codable {
    var albums:[album]
}
