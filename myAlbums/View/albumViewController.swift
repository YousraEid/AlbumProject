//
//  albumViewController.swift
//  myAlbums
//
//  Created by apple on 24/04/2022.
//

import UIKit
import RxSwift
import Kingfisher

class albumViewController: UIViewController {
    let photoViewModel = PhotosViewModel()
    let disposeBag = DisposeBag()
    var screenSize : CGRect!
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    var albumId : Int = 0
    var nameOfAlbum = ""
    var photos : [photo] = []
    var realPhotos : [photo] = []
    

    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 120, height: 120)
//        albumCollectionView.collectionViewLayout = layout
        self.navigationItem.hidesSearchBarWhenScrolling = false
        layOutOfCells()
        fetchPhotos(with: albumId)
        
    }
    func fetchPhotos(with id : Int){
        photoViewModel.getPhotos(with: id).subscribe(onCompleted: {
                   //print(photoViewModel.photos)
            self.photos = self.photoViewModel.photos
            self.realPhotos = self.photos
            self.navigationItem.title = self.nameOfAlbum
            self.albumCollectionView.reloadData()
               }, onError: nil, onDisposed: nil).disposed(by: disposeBag)
        
       
    }
    
    func layOutOfCells(){
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height

       
       let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
              layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
              layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
              layout.minimumInteritemSpacing = 0
              layout.minimumLineSpacing = 0
              albumCollectionView!.collectionViewLayout = layout

       albumCollectionView.register(albumCollectionViewCell.nib(), forCellWithReuseIdentifier: albumCollectionViewCell.identifier)
    }
    

    

}
extension albumViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCollectionViewCell.identifier, for: indexPath) as! albumCollectionViewCell
        cell.layer.borderWidth = 0.5
        cell.frame.size.width = screenWidth/3
        cell.frame.size.height = screenWidth/3
        cell.configure(with: UIImage(named: "b3")!)
        
        let urlImage = URL(string: self.photos[indexPath.row].url)
        cell.imageView.kf.setImage(with: urlImage) { result in
           switch result {
           case .success(let value):
               print("Image: \(value.image). Got from: \(value.cacheType)")
            cell.imageView.image = value.image
           case .failure(let error):
               print("Error: \(error)")
           }
         }
        
        
        
        return cell
    }
    

    
}

extension albumViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControllerNavigateTo = storyboard?.instantiateViewController(withIdentifier: "imageViewerViewController")as? imageViewerViewController
        viewControllerNavigateTo?.urlImageString = self.photos[indexPath.row].url
        
        navigationController?.pushViewController(viewControllerNavigateTo!, animated: true)
        
    }
    
}

extension albumViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/3, height: screenWidth/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 406, height: 42)
    }
    
}

extension albumViewController : UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader){
            let searchView : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
        }
        return UICollectionReusableView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.photos.removeAll()
        for item in self.realPhotos {
            if( item.title.lowercased().contains(searchBar.text!.lowercased())){
                self.photos.append(item)
            }
                
        }
        if(searchBar.text!.isEmpty){
            self.photos = self.realPhotos
        }
        self.albumCollectionView.reloadData()
    }
    
}
