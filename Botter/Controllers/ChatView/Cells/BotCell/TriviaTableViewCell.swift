//
//  TriviaCollectionViewCell.swift
//  Botter
//
//  Created by Nora on 6/14/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class TriviaTableViewCell: HeroTableViewCell {
    
    
    override func prepareForReuse() {
        self.msg = b_BasicMessage()
        collectionView.reloadData()
        collectionView.reloadInputViews()
        collectionView.layoutSubviews()
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    
    
}
