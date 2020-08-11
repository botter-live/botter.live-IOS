//
//  EndFormViewController.swift
//  Botter
//
//  Created by Nora on 7/19/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class b_EndFormViewController: b_LocalizableViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var form = b_Form()
    var dataCells = [UITableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCells()
        self.tableView.reloadData()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the self.
    }
    
    @IBAction func botterWebsiteClicked (){
        CommonActions.botterSiteClicked()
    }
    
    override func b_backDismiss(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getCells(){
        dataCells.removeAll()
        for item in self.form.inputs {
            switch item.type {
            case .textfield:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextInputTableViewCell") as? TextInputTableViewCell
                cell?.setData(input: item)
                dataCells.append(cell ?? UITableViewCell())
                break
            case .textarea:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextAreaInputTableViewCell") as? TextAreaInputTableViewCell
                cell?.setData(input: item)
                dataCells.append(cell ?? UITableViewCell())
                break
            case .date:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "DateIntputTableViewCell") as? DateIntputTableViewCell
                cell?.setData(input: item ,parent: self )
                dataCells.append(cell ?? UITableViewCell())
                break
            case .time:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "TimeInputTableViewCell") as? TimeInputTableViewCell
                cell?.setData(input: item, parent: self )
                dataCells.append(cell ?? UITableViewCell())
                break
            case .radio :
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "RadioInputTableViewCell") as? RadioInputTableViewCell
                cell?.setData(input: item)
                dataCells.append(cell ?? UITableViewCell())
                break
            case .select :
                if item.multiple{
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "SelectInputTableViewCell") as? SelectInputTableViewCell
                    cell?.setData(input: item)
                    dataCells.append(cell ?? UITableViewCell())
                }else{
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "RadioInputTableViewCell") as? RadioInputTableViewCell
                    cell?.setData(input: item)
                    dataCells.append(cell ?? UITableViewCell())
                    break
                }
                break
            default:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextInputTableViewCell") as? TextInputTableViewCell
                cell?.setData(input: item)
                dataCells.append(cell ?? UITableViewCell())
                break
            }
            
        }
        
    }
    
}
extension b_EndFormViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataCells[indexPath.row]
    }
}
