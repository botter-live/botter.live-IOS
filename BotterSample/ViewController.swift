//
//  ViewController.swift
//  BotterSDKSample
//
//  Created by Nora on 6/7/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import Botter

class ViewController: UIViewController {

    var bottomMargin = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func action(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HiddenLauncherViewController") as? HiddenLauncherViewController
        self.present(vc! , animated: true, completion: nil)
    } 
    
    @IBAction func toggleBtnPosition(){
        switch bottomMargin {
        case 0:
            bottomMargin = 40
            break
        case 40:
            bottomMargin = 100
            break
        case 100:
            bottomMargin = 0
            break
        default:
            break
        }
        
        Botter.setLauncherBottomMargin(marginValue: Float(bottomMargin))
    }

}
 
