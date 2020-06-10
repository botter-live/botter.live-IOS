//
//  GallaryTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class GallaryTableViewCell: BotChatTableViewCell {
    
    
    @IBOutlet weak var collectionView : CustomCollection!
    
    var actionClicked:((Action)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(msg : BasicMessage , showIcon : Bool = false){
           super.setData(msg : msg , showIcon: showIcon)
           self.msg = msg
           botIcon.isHidden = !showIcon
       }
    
    override func prepareForReuse() {
        self.msg = BasicMessage()
        collectionView.reloadData()
    }

}

extension GallaryTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.msg.galleryItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        cell.setData(item: self.msg.galleryItems[indexPath.row])
        cell.actionClicked = self.actionClicked
        return cell
    }
}

extension GallaryTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize.init(width: 200, height: 228)
    }
}
