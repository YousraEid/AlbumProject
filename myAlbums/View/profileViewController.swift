//
//  profileViewController.swift
//  myAlbums
//
//  Created by apple on 24/04/2022.
//

import UIKit
import RxSwift

class profileViewController: UIViewController {
    let userViewModel = UsersViewModel()
    let albumViewModel = AlbumViewModel()
   
    
    var users : [user] = []
    var selectedUser : user?
    var albums : [album] = []
   
    
    
     
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var address: UILabel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var AlbumsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let servicse = userService()
//        servicse.fetchUser().subscribe(onNext:{ users in
//            print(users)
//        }).disposed(by: disposeBag)
        
       
        userViewModel.fetchUsers().subscribe(onCompleted: {
           // print(userViewModel.users)
            self.users = self.userViewModel.users
            self.selectedUser = self.users.randomElement()
            self.fetchAlbums(with: self.selectedUser?.id ?? 1)
           
            
            
        }, onError: nil, onDisposed: nil).disposed(by: disposeBag)
        
       
//        
//        photoViewModel.getPhotos(with: 1).subscribe(onCompleted: {
//            //print(photoViewModel.photos)
//            self.photos = self.photoViewModel.photos
//        }, onError: nil, onDisposed: nil).disposed(by: disposeBag)
//        
       
       
      

    }
    
    func fetchAlbums(with id : Int){
        albumViewModel.getAlbum(with: id).subscribe(onCompleted: {
            //print(albumViewModel.albums)
            self.albums = self.albumViewModel.albums
            self.updateUi()
        }, onError: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func updateUi() {
        if let selectedUser = selectedUser {
            userName.text = "Hi,\(String(describing: selectedUser.name))"
            address.text = "\(selectedUser.address.street), \(selectedUser.address.suite), \(selectedUser.address.city), \(selectedUser.address.zipcode)"
            AlbumsTableView.reloadData()
        }
        
    }


}
extension profileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = albums[indexPath.row].title
        return cell
    }
    
    
}
extension profileViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewControllerNavigateTo = storyboard?.instantiateViewController(withIdentifier: "albumViewController")as? albumViewController
        viewControllerNavigateTo?.albumId = albums[indexPath.row].id
        viewControllerNavigateTo?.nameOfAlbum = albums[indexPath.row].title
        
        
        navigationController?.pushViewController(viewControllerNavigateTo!, animated: true)
    }
    
}
