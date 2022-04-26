//
//  UserModel.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation

struct companyDict : Codable {
    var name : String
    var catchPhrase : String
    var bs : String
}
struct geoDict : Codable {
    var lat : String
    var lng : String
}
struct addressDict : Codable {
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : geoDict
}
struct user :Codable {
    var id : Int
    var name : String
    var username : String
    var email : String
    var address : addressDict
    var phone : String
    var website : String
    var company : companyDict
   
    
}

