//
//  GalleryItemCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import LazyImage

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemTitle : UILabel!
    @IBOutlet weak var itemActionBtn : UIButton!
    
    var lazyImage = LazyImage()
    var actionClicked:((Action)->())!
    var item = GallaryItem()
    
    func setData(item : GallaryItem){
        self.item = item
        self.lazyImage.show(imageView: self.itemImage! , url: item.imageUrl) { (lazyError) in
            print(lazyError?.localizedDescription)
        }
        itemActionBtn.isHidden = !item.hasAction
        itemTitle.text = item.title
    }
    
    @IBAction func actionPressed(){
        if self.actionClicked != nil{
            actionClicked(self.item.action)
        }
    }
}
