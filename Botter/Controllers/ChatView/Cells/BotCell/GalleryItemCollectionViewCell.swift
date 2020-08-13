//
//  GalleryItemCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
//import LazyImage

class GalleryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemTitle : UILabel!
    @IBOutlet weak var itemdesc : UILabel!
    @IBOutlet weak var gifView : UIView!
    @IBOutlet weak var videoView : UIView!
    @IBOutlet weak var gifIcon : UIImageView!
    @IBOutlet weak var gifImage : UIImageView!
    @IBOutlet weak var itemActionStack : UIStackView!
    
    var lazyImage = LazyImage()
    var actionClicked:((b_Action)->())!
    var item = b_GallaryItem()
    var openVideo : ((String)->())!
    
    func setData(item : b_GallaryItem , maxCount : Int){
        self.item = item
        gifImage.image = nil
        itemImage.image = nil
        itemdesc.text = item.desc
        
        if item.title == "" {
            itemTitle.text = "dummy"
            itemTitle.alpha = 0
        }else{
            itemTitle.text = item.title
            itemTitle.alpha = 1
        }
        
        
        gifView.isHidden = item.mediaType != .gif
        videoView.isHidden = item.mediaType != .video
        gifImage.isHidden = item.mediaType != .gif
        itemImage.isHidden = item.mediaType == .gif
        switch item.mediaType {
        case .image:
            if item.imageUrl != "" {
                DispatchQueue.main.async {
                    self.lazyImage.show(imageView: self.itemImage! , url: item.imageUrl) { (lazyError) in
                    }
                }
            }
            break
        case .video:
            if item.thumbnail != "" {
                DispatchQueue.main.async {
                    self.lazyImage.show(imageView: self.itemImage!, url: item.thumbnail) { (lazyError) in
                        //            print(lazyError?.localizedDescription)
                    }
                }
            }
            break
        case .gif:
            if item.imageUrl != "" {
            self.gifImage?.b_setGifFromURL(URL.init(string: item.imageUrl)!, manager: SwiftyGifManager.defaultManager , loopCount: 0, levelOfIntegrity: GifLevelOfIntegrity(5), showLoader: true)
            }
            break
        }
        
        for index in 1...3{
            if let btn = itemActionStack.viewWithTag(index) as? UIButton{
                btn.isHidden = maxCount < index
                btn.alpha = item.actions.count < index ? 0 : 1
                if !btn.isHidden && btn.alpha != 0{
                    btn.setTitle(item.actions[index - 1].title , for: .normal)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.item = b_GallaryItem()
        gifImage.image = nil
        itemImage.image = nil
    }
    
    @IBAction func actionPressed(_ sender : UIButton){
        if self.actionClicked != nil{
            actionClicked(self.item.actions[sender.tag - 1])
        }
    }
    
    @IBAction func gifBtnPressed(){
        if gifImage?.isAnimatingGif() ?? false{
            gifImage?.stopAnimatingGif()
            gifIcon.isHidden = false
        }else{
            gifIcon.isHidden = true
            gifImage?.loopCount = -1
            gifImage?.startAnimatingGif()
        }
    }
    
    @IBAction func playVideoClicked(){
        if openVideo != nil{
            openVideo(item.imageUrl)
        }
    }
}
