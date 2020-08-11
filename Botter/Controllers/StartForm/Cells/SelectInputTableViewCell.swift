//
//  SelectInputTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class SelectInputTableViewCell: BasicFormTableViewCell {
    
    @IBOutlet weak var titleLbl : b_BasicRegularLbl!
    @IBOutlet weak var collectionView : CustomCollection!
    
    var sizingCell: SelectCollectionViewCell?
    var selectedText = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "SelectCollectionViewCell", bundle: MyFrameworkBundle.bundle)
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! SelectCollectionViewCell?
        collectionView.register(cellNib, forCellWithReuseIdentifier: "SelectCollectionViewCell")
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(input: b_FormInput) {
        super.setData(input: input)
        titleLbl.text = input.label
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        self.layoutIfNeeded()
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        self.input = b_FormInput()
        collectionView.reloadData()
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override func getAnswer() -> Any {
        self.answer = selectedText.joined(separator: ", ")
        return selectedText
    }
    
}
extension SelectInputTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.input.options.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as! SelectCollectionViewCell
        cell.setData(text: self.input.options[indexPath.item], selected: selectedText.contains(self.input.options[indexPath.item]))
        
        return cell
    }
}
extension SelectInputTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = self.input.options[indexPath.item]
        if selectedText.contains(text){
            selectedText.removeAll(where: {$0 == text})
        }else{
            selectedText.append(text)
        }
        
        collectionView.reloadData()
    }
}

extension SelectInputTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell?.setData(text: self.input.options[indexPath.item], selected: selectedText.contains(self.input.options[indexPath.item]) )
       let w = self.sizingCell!.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        return CGSize.init(width: w, height: 40)
    }
    
}

