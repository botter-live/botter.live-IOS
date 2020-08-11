//
//  b_LocalizableViewController.swift
//  Botter
//
//  Created by Nora on 8/12/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class b_LocalizableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
        b_Localize()
    }
    
    func b_Localize(){
        if self is b_ChatViewController{
            
        }else{
            //setDirection
            b_SetDirections()
            if BotterSettingsManager.language == .arabic{
                setText(tView: self.view)
            }
        }
    }
    
    
    func b_SetDirections(){
        if BotterSettingsManager.language == .arabic{
            setRTL(tView: self.view)
        }else{
            setLTR(tView: self.view)
        }
    }
    
    func setRTL(tView : UIView){
        view.setNeedsLayout()
        tView.semanticContentAttribute = .forceRightToLeft
        view.layoutIfNeeded()
        for v in tView.subviews{
            setRTL(tView: v)
        }
    }
    
    func setLTR(tView : UIView){
        tView.setNeedsLayout()
        tView.semanticContentAttribute = .forceLeftToRight
        tView.layoutIfNeeded()
        for v in tView.subviews{
            setLTR(tView: v)
        }
    }
    
    func setText(tView  : UIView){
        
        let img1 = UIImage(named: "arrowRight", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        let img2 = UIImage(named: "arrowRight1", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        let img3 = UIImage(named: "back_arrow", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        
        for v in tView.subviews{
            if let lbl = v as? UILabel{
                let str = BotterSettingsManager.language == .arabic ? CommonActions.loadText(for: lbl.text ?? "") : lbl.text
                lbl.text =  str
            }
            if let btn = v as? UIButton{
                let str = btn.title(for: .normal)?.b_localize()
                btn.setTitle(str, for: .normal)
                if btn.tag == 101{
                    btn.transform = CGAffineTransform(scaleX: -1, y: 1);
                }else{
                    if let img = btn.image(for: .normal){
                        if img.isEqual(img1)
                            || img.isEqual(img2)
                            || img .isEqual(img3){
                            
                            btn.transform = CGAffineTransform(scaleX: -1, y: 1);
                            
                        }
                    }
                }
            }
            
            if let imgView = v as? UIImageView{
                if imgView.tag == 101{
                    imgView.transform = CGAffineTransform(scaleX: -1, y: 1);
                }else{
                    if let img = imgView.image{
                        if img.isEqual(img1)
                            || img.isEqual(img2)
                            || img .isEqual(img3){
                            
                            imgView.transform = CGAffineTransform(scaleX: -1, y: 1);
                            
                        }
                    }
                }
            }
            
            if !(tView is UICollectionView){
                setText(tView: v)
            }
        }
    }
    

}
