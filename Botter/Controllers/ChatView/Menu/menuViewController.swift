//
//  menuViewController.swift
//  Botter
//
//  Created by Nora on 7/21/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class b_menuViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var doneActionHandler: ((b_MenuItem)->Void)?
    
    var menu = b_Menu()
    var selected = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 25;
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    static func open(in parent:UIViewController ,menu : b_Menu, completion:@escaping((b_MenuItem)->())){
            let content: ContentSheetContentProtocol
            let vc = b_menuViewController.b_instantiateFromStoryBoard(appStoryBoard: .Main)
        vc.menu = menu
            vc.doneActionHandler = { item in
               
                completion(item)
            }
            let contentController = vc
            content = contentController
            let contentSheet = ContentSheet(content: content)
            contentSheet.blurBackground = false
            contentSheet.showDefaultHeader = false
        
            parent.present(contentSheet, animated: true, completion: nil)
            
        }

}
extension b_menuViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.actions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selected == section ? menu.actions[section].actions.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if let titleLbl = cell?.viewWithTag(1) as? UILabel{
            titleLbl.text = menu.actions[indexPath.section].actions[indexPath.row].title
        }
        return cell ?? UITableViewCell()
    }
    
    @objc func selectMenuItem(_ sender : UIButton){
        let section = sender.tag
        let item = menu.actions[section]
        if item.actions.count > 0{
            if selected == section {
                selected = -1
            }else{
                selected = section
            }
            tableView.reloadData()
        }else{
            actionPressed(action: item)
        }
    }
    
    func actionPressed(action : b_MenuItem){
        if doneActionHandler != nil{
            doneActionHandler!(action)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collapsedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return 280
    }
    override func scrollViewToObserve(containedIn contentSheet: ContentSheet) -> UIScrollView? {
        return tableView
    }
    override func expandedHeight(containedIn contentSheet: ContentSheet) -> CGFloat {
        return UIScreen.main.bounds.height - 50
    }
}
extension b_menuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "header")
        if let titleLbl = view?.viewWithTag(1) as? UILabel{
            titleLbl.text = menu.actions[section].title
        }
        
        if let arrowImage = view?.viewWithTag(2) as? UIImageView{
            arrowImage.isHidden = menu.actions[section].actions.count == 0
        }
        
        if let actionBtn = view?.viewWithTag(3) as? UIButton{
            actionBtn.removeTarget(self, action: nil, for: .allEvents)
            actionBtn.tag = section
            actionBtn.addTarget(self, action: #selector(selectMenuItem(_:)), for: .touchUpInside)
        }
        
        return view ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionPressed(action: menu.actions[indexPath.section].actions[indexPath.row])
    }
}
