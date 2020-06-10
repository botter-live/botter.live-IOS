//
//  GalleryItemCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemTitle : UILabel!
    @IBOutlet weak var itemActionBtn : UIButton!
    
    var actionClicked:((Action)->())!
    var item = GallaryItem()
    
    func setData(item : GallaryItem){
        self.item = item
        itemImage?.sd_setShowActivityIndicatorView(true)
        itemImage?.sd_setIndicatorStyle(.white)
        itemImage?.sd_setImage(with: URL.init(string: item.imageUrl), completed: nil)
        itemActionBtn.isHidden = !item.hasAction
        itemTitle.text = item.title
    }
    
    @IBAction func actionPressed(){
        if self.actionClicked != nil{
            actionClicked(self.item.action)
        }
    }
}
