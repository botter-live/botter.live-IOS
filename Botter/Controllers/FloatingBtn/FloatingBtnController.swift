//
//  FloatingBtnController.swift
//  Botter
//
//  Created by Nora on 6/2/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
//import b_IQKeyboardManagerSwift

class b_FloatingBtnController: UIViewController {
    
    private(set) var button: UIButton!
    
    var window : FloatingButtonWindow?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init() {
        window = FloatingButtonWindow()
        super.init(nibName: nil, bundle: nil)
        window?.rootViewController = self
        window?.button = self.button
        window?.fView = self.view
        window?.floatingButtonController = self
        b_IQKeyboardManager.shared.enable = true
        b_IQKeyboardManager.shared.shouldResignOnTouchOutside =  true
        b_IQKeyboardManager.shared.disabledDistanceHandlingClasses = [b_ChatViewController.self]
        window?.makeKeyAndVisible()
    }
    
    func keyboardDidShow(note: NSNotification) {
        window?.windowLevel = UIWindow.Level(rawValue: 0)
        window?.windowLevel = UIWindow.Level.alert + 1
    }
    
//    vieww
    
    override func loadView() {
        let view = UIView()
        if self.button != nil{
            self.button.removeFromSuperview()
        }
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.backgroundColor = BotterSettingsManager.LauncherColor
    
        var image = UIImage(named: "ic-chat", in: MyFrameworkBundle.bundle , compatibleWith: nil)!
        if BotterSettingsManager.chatIcon != nil{
            image = BotterSettingsManager.chatIcon
        }
        button.setImage(image , for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.tintColor = BotterSettingsManager.FontColor
        button.layer.shadowRadius = 3
        button.layer.cornerRadius = 30
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize.zero
        button.clipsToBounds = true
        button.sizeToFit()
        
        let bottomInset = self.window?.safeAreaInsets.bottom ?? 0
        let height : CGFloat = 60
        let screenSpecs = UIScreen.main.bounds
        let mWidth : CGFloat = 60
        let x : CGFloat = BotterSettingsManager.alignLauncherLeft ? 40 : screenSpecs.width - mWidth - 40
        button.frame = CGRect(origin: CGPoint(x: x , y: (screenSpecs.height - BotterSettingsManager.bottomMargin - bottomInset - height)), size: CGSize.init(width: mWidth , height: height ))
        button.autoresizingMask = []
        view.addSubview(button)
        
        let notificationCount = NotificationManager.shared.getNotificationCount()
        if notificationCount > 0 {
            let notificationView = b_RoundedView.init(frame: CGRect.init(x: button.frame.origin.x + mWidth - 12  , y: button.frame.origin.y + 2  , width: 24, height: 24))
            notificationView.backgroundColor = .red
            let lbl = UILabel.init(frame: notificationView.frame)
            lbl.textAlignment = .center
            lbl.text = "\(notificationCount)"
            lbl.textColor = .white
            lbl.font = UIFont.systemFont(ofSize: 11)
            lbl.font = BotterSettingsManager.Font.getRegularFontForLabel(lbl: lbl)
            lbl.backgroundColor = .clear
            notificationView.addSubview(lbl)
            view.addSubview(notificationView)
            view.addSubview(lbl)
        }
        self.view = view
        self.button = button
        self.button.addTarget(self, action: #selector(floatingButtonWasTapped), for: .touchUpInside)
        
        window?.button =  self.button
        self.view.isHidden = hideLauncher()
        window?.fView = self.view
        
    }
    
    @objc func floatingButtonWasTapped() {
        Botter.openChat(parent: self)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func hideLauncher()->Bool{
        let windows = UIApplication.shared.windows
        if let window = windows.last(where:  { (window) -> Bool in
            !(window is FloatingButtonWindow)
        }){
            if let visible = window.b_visibleViewController{
                return visible is BotterControllerWithHiddenLauncher
            }
            
            return false
        }
        
        return false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        loadView()
    }
    
  
}

class FloatingButtonWindow: UIWindow {
    
    var button: UIButton?
    var fView : UIView?
    weak var floatingButtonController: b_FloatingBtnController?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = nil
        windowLevel = UIWindow.Level.alert + 1
        isHidden = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if  self.b_visibleViewController is b_FloatingBtnController{
            guard let button = button else { return false }
            let buttonPoint = convert(point, to: button)
            return button.point(inside: buttonPoint, with: event)
        }else{
            return true
        }
    }
    
    func resetButtonPlace(){
        floatingButtonController?.loadView()
    }
    
}

open class BotterControllerWithHiddenLauncher : UIViewController  {
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Botter.hideLauncherButton()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if !hideLauncher(){
//            Botter.showLauncherButton()
//        }else{
//            Botter.hideLauncherButton()
//        }
        Botter.showLauncherButton()
        
    }
    
    func hideLauncher()->Bool{
        let windows = UIApplication.shared.windows
        if let window = windows.last(where:  { (window) -> Bool in
            !(window is FloatingButtonWindow)
        }){
            if let visible = window.b_visibleViewController{
                return visible is BotterControllerWithHiddenLauncher
            }
            
            return false
        }
        
        return false
    }
}

@objcMembers
public final class MyFrameworkBundle {
    public static let main: Bundle = Bundle(for: MyFrameworkBundle.self)

    
    static var bundle:Bundle! {
        let podBundle = Bundle(for: b_FloatingBtnController.self)

        if let bundleURL = podBundle.url(forResource: "Botter", withExtension: "bundle"){
            //        print("bundel : " + (bundleURL!.absoluteString) )
            return Bundle(url: bundleURL) ?? nil
        }else{
            return podBundle
        }
    }
    
    
}

