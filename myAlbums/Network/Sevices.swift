//
//  Sevices.swift
//  myAlbums
//
//  Created by apple on 25/04/2022.
//

import Foundation
import Moya
import RxSwift

//class userService {
//    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
//    func fetchUser()-> Observable<[user]>{
//        return Observable.create { observer in
//            let task = URLSession.shared.dataTask(with: self.url!) { data, response, error in
//                guard let data = data else {
//                    observer.onError(NSError(domain: "", code: -1,userInfo: nil))
//                    return
//                }
//
//
//            do{
////            let data = try Data(contentsOf: url, options: .mappedIfSafe)
//                let users = try JSONDecoder().decode([user].self, from: data)
//                observer.onNext(users)
//            }catch{
//                observer.onError(error)
//            }
//            }
//            task.resume()
//
//            return Disposables.create{}
//            task.cancel()
//    }
//}
//}



typealias Method = Moya.Method
enum FourmService {
    case getUser
    case getAlbum(userId:Int)
    case getPhotos(albumId:Int)
    
}

extension FourmService : TargetType {
    
   
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/users"
        case .getAlbum(_):
            return "/albums"
        case .getPhotos(_):
            return "/photos"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        case .getAlbum(let userId):
            return .requestParameters(parameters: ["userId" : userId], encoding: URLEncoding.queryString)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId" : albumId], encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
