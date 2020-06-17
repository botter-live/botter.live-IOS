//
//  HeroTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/4/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class HeroTableViewCell: BotChatTableViewCell {

    @IBOutlet weak var collectionView : CustomCollection!
    public var flowLayout: tagViewLayOut? {
        get {
            return collectionView.collectionViewLayout as? tagViewLayOut
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    var sizingCell: TagCollectionViewCell?
    var actionClicked:((Action)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "TagCollectionViewCell", bundle: MyFrameworkBundle.bundle)
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCollectionViewCell?
        collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCollectionViewCell")
        self.flowLayout?.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(msg: BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
    
    override func prepareForReuse() {
        self.msg = BasicMessage()
        collectionView.reloadData()
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
}

extension HeroTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.msg.actions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        cell.setData(action: self.msg.actions[indexPath.item])
        return cell
    }
}
extension HeroTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.actionClicked != nil{
            self.msg.actions[indexPath.item].msgIndex = self.msg.msgIndex
            actionClicked(self.msg.actions[indexPath.item])
        }
    }
}

extension HeroTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell?.setData(action: self.msg.actions[indexPath.item])
       let w = self.sizingCell!.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        return CGSize.init(width: w, height: 40)
    }
}

class CustomCollection : UICollectionView{
    override func layoutSubviews() {
      super.layoutSubviews()
      if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
         self.invalidateIntrinsicContentSize()
      }
    }

      override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
      }
}
