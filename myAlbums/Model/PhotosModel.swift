//
//  PhotosModel.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation

struct photo : Codable {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailUrl : String
}

struct photoDist : Codable {
    var photos : [photo]
}
