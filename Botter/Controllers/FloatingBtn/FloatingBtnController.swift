//
//  FloatingBtnController.swift
//  Botter
//
//  Created by Nora on 6/2/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class FloatingBtnController: UIViewController {
    
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
        window?.floatingButtonController = self
        window?.makeKeyAndVisible()
    }
    
    func keyboardDidShow(note: NSNotification) {
        window?.windowLevel = UIWindow.Level(rawValue: 0)
        window?.windowLevel = UIWindow.Level.alert + 1
    }
    
    override func loadView() {
        let view = UIView()
        if self.button != nil{
            self.button.removeFromSuperview()
        }
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.backgroundColor = UIColor.init(codeString: "#642C7A")
//        let frameworkBundle = Bundle.init(for: FloatingBtnController.self)
//        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("BotterSDK.bundle")
       
//        let podBundle = Bundle(path: Bundle(for: FloatingBtnController.self). path(forResource: "Botter", ofType: "bundle")!)
//MyFrameworkBundle.bundle
        let image = UIImage(named: "ic-chat", in: MyFrameworkBundle.bundle , compatibleWith: nil)
        button.setImage(image , for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.cornerRadius = 30
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize.zero
        button.clipsToBounds = true
        button.sizeToFit()
        
        let bottomInset = self.window?.safeAreaInsets.bottom ?? 0
        let height : CGFloat = 60
        let screenSpecs = UIScreen.main.bounds
//        let viewFrame = self.view.frame
//        print(viewFrame)
        button.frame = CGRect(origin: CGPoint(x: screenSpecs.width - 100, y: (screenSpecs.height - FloatingButtonWindow.bottomMargin - bottomInset - height)), size: CGSize.init(width: 60, height: height ))
        button.autoresizingMask = []
        view.addSubview(button)
        self.view = view
        self.button = button
        self.button.addTarget(self, action: #selector(floatingButtonWasTapped), for: .touchUpInside)
        window?.button = button
    }
    
    @objc func floatingButtonWasTapped() {
        Botter.openChat(parent: self)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
  
}

class FloatingButtonWindow: UIWindow {
    
    var button: UIButton?
    static var bottomMargin : CGFloat = 40
    weak var floatingButtonController: FloatingBtnController?
    
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
        if  self.visibleViewController is FloatingBtnController{
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
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Botter.showLauncherButton()
        
    }
}
public final class MyFrameworkBundle {
    public static let main: Bundle = Bundle(for: MyFrameworkBundle.self)

    
    static var bundle:Bundle! {
        let podBundle = Bundle(for: FloatingBtnController.self)

        if let bundleURL = podBundle.url(forResource: "Botter", withExtension: "bundle"){
            //        print("bundel : " + (bundleURL!.absoluteString) )
            return Bundle(url: bundleURL) ?? nil
        }else{
            return podBundle
        }
    }
    
    
}
