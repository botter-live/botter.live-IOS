//
//  FaqsListViewController.swift
//  Botter
//
//  Created by SherifShokry on 7/21/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class FaqsListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var faqsList = [FaqData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    
}

extension FaqsListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaqCell", for: indexPath) as! FaqCell
        cell.setData(faqItem: faqsList[indexPath.row].body)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FaqsDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Forms)
        vc.faqItem = faqsList[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

