//
//  HiddenLauncherViewController.swift
//  BotterSample
//
//  Created by Nora on 6/11/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import Botter

class HiddenLauncherViewController: BotterControllerWithHiddenLauncher {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   @IBAction func openChat(){
        
        // this will not hide chat icon as the line of BotterSDK.show()
        // is in appDelegate class
        Botter.openChatScreen(APIKey: "nKmovPCdWNZ")
    }

}
