//
//  LoaderManager.swift
//  Masters
//
//  Created by Nora on 3/7/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import UIKit

class b_LoaderManager: NSObject {
    
    var loader : b_LoaderView!
    let defaultColor = UIColor.init(codeString: "#2E332F").withAlphaComponent(0.2)
    
    override init() {
        super.init()
        if let bundel = MyFrameworkBundle.bundle{
            loader = bundel.loadNibNamed("LoaderView", owner: self , options: nil)?.first as? b_LoaderView
            
        }
    }
    
    
    func show(inRect rect : CGRect , inView view : UIView , bgColor : UIColor? = UIColor.white.withAlphaComponent(0.9) , radius : CGFloat? = 0 ){
        self.remove()
        if bgColor != nil{
            loader.backgroundColor = bgColor
        }else{
            loader.backgroundColor = defaultColor
        }
        
        loader.backgroundColor = defaultColor
        
        loader.frame = rect
        if radius != nil{
            loader.b_cornerRadius = radius ?? 0
        }
        if #available(iOS 13.0, *) {
            loader.loaderIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
            loader.loaderIndicator.style = .whiteLarge
        }
//        loader.loaderIndicator.color = Colors.appPrimeryColor
        view.addSubview(loader)
        view.bringSubviewToFront(loader)
//        loader.animate()
        
    }
    
    func showWithClearBG(inRect rect : CGRect , inView view : UIView ){
        //        setPickerSpec()
       loader.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        loader.frame = rect
        if #available(iOS 13.0, *) {
            loader.loaderIndicator.style = .large
        } else {
            // Fallback on earlier versions
            loader.loaderIndicator.style = .whiteLarge
        }
        loader.loaderIndicator.color = BotterSettingsManager.AccentColor
//        loader.loaderIndicator.color = Colors.appPrimeryColor
        view.addSubview(loader)
        view.bringSubviewToFront(loader)
        loader.animate()
        
    }
    
    func remove(){
        loader.removeFromSuperview()
    }
}
