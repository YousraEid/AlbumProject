//
//  imageViewerViewController.swift
//  myAlbums
//
//  Created by apple on 26/04/2022.
//

import UIKit
import Kingfisher
import SwiftUI

class imageViewerViewController: UIViewController {
    
    var urlImageString = ""
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        
        scrollView.delegate = self
        
        

        let url = URL(string: urlImageString)
        imageView.kf.setImage(with: url) { result in
           switch result {
           case .success(let value):
               print("Image: \(value.image). Got from: \(value.cacheType)")
               self.imageView.image = value.image
           case .failure(let error):
               print("Error: \(error)")
           }
            
    
    }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(addTapped))

}
    @objc func addTapped (){
        let activityVc = UIActivityViewController(activityItems: [self.imageView.image], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        self.present(activityVc, animated: true, completion: nil)
    }
    
}
extension imageViewerViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1{
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHieght = image.size.height * ratio
                
                let conditionLeft = newWidth * scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                
                let conditionTop = newHieght * scrollView.zoomScale > imageView.frame.height
                let top = 0.5 * (conditionTop ? newHieght - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }else{
            scrollView.contentInset = .zero
        }
    }
}

