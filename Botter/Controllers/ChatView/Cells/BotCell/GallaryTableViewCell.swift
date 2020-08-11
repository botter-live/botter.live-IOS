//
//  GallaryTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class GallaryTableViewCell: BotChatTableViewCell {
    
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var actionClicked:((b_Action)->())!
    var openVideo : ((String)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(msg : b_BasicMessage , showIcon : Bool = false){
           super.setData(msg : msg , showIcon: showIcon)
           self.msg = msg
           botIcon.isHidden = !showIcon
        collectionView.reloadData()
       }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.msg = b_BasicMessage()
        collectionView.reloadData()
    }

}

extension GallaryTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.msg.galleryItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        
        let max = msg.galleryItems.map { $0.actions.count }.max() ?? 0
        cell.setData(item: self.msg.galleryItems[indexPath.row], maxCount: max)
        cell.actionClicked = self.actionClicked
        cell.openVideo = self.openVideo
        cell.layoutIfNeeded()
        return cell
    }
}

extension GallaryTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize.init(width: 270, height: 320)
    }
}
