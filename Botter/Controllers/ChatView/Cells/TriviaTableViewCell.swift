//
//  TriviaCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 6/14/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TriviaTableViewCell: HeroTableViewCell {
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // set custom behavior for trivia option
    }
    
    override func prepareForReuse() {
        self.msg = BasicMessage()
        collectionView.reloadData()
        collectionView.reloadInputViews()
        collectionView.layoutSubviews()
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
}
