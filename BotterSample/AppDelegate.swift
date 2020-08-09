//
//  AppDelegate.swift
//  BotterSDKSample
//
//  Created by Nora on 6/7/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import Botter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // to show chat icon over entir app
        customizeChat()
        Botter.show(APIKey: "9nw32y9gfqf59gye7y7")
//        "9nw32y9gfqf59gye7y7"
//        "nKmovPCdWNZdYnIejRnd"
        return true
    }
//
    
    func customizeChat(){
//        BotterSettingsManager.AccentColor = UIColor.init(colorString: "#97a258")
//        BotterSettingsManager.BotterMessageBGColor = UIColor.init(colorString: "#dbedd5")
        BotterSettingsManager.Font.regularFontName = "Roboto-Regular"
        BotterSettingsManager.Font.mediumFontName = "Roboto-Medium"
//        BotterSettingsManager.alignLauncherLeft = true
        
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.absoluteString)
        return true
    }

}

 
extension UIColor {

    convenience init(colorString: String) {
        self.init(colorString: colorString, alpha:1)
    }

    convenience init(colorString: String, alpha: CGFloat) {
        var hexWithoutSymbol = colorString
        if hexWithoutSymbol.hasPrefix("#") {
//            var str = codeString
            let _ = hexWithoutSymbol.remove(at: colorString.startIndex)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
}
