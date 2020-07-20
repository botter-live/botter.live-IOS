//
//  RadioInputTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/16/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class RadioInputTableViewCell: BasicFormTableViewCell {

    @IBOutlet weak var titleLbl : BasicRegularLbl!
    @IBOutlet weak var collectionView : CustomCollection!
    
    var sizingCell: RadioCollectionViewCell?
    var selectedText = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "RadioCollectionViewCell", bundle: MyFrameworkBundle.bundle)
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! RadioCollectionViewCell?
        collectionView.register(cellNib, forCellWithReuseIdentifier: "RadioCollectionViewCell")
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(input: FormInput) {
        super.setData(input: input)
        titleLbl.text = input.label
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        self.layoutIfNeeded()
        self.layoutIfNeeded()
    }
  
    override func prepareForReuse() {
        self.input = FormInput()
        collectionView.reloadData()
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override func getAnswer() -> Any {
        self.answer = selectedText
        return selectedText
    }
    
}
extension RadioInputTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.input.options.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadioCollectionViewCell", for: indexPath) as! RadioCollectionViewCell
        cell.setData(text: self.input.options[indexPath.item], selected: self.input.options[indexPath.item].lowercased() == selectedText.lowercased())
        
        return cell
    }
}
extension RadioInputTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = self.input.options[indexPath.item]
        if text.lowercased() == selectedText.lowercased(){
            selectedText = ""
        }else{
            selectedText = text
        }
        collectionView.reloadData()
    }
}

extension RadioInputTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell?.setData(text: self.input.options[indexPath.item], selected: self.input.options[indexPath.item].lowercased() == selectedText.lowercased())
       let w = self.sizingCell!.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        return CGSize.init(width: w, height: 40)
    }
}
