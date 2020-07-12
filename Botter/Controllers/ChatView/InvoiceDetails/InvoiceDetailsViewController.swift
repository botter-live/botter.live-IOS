//
//  InvoiceDetailsViewController.swift
//  Botter
//
//  Created by Nora on 7/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class InvoiceDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!

    var invoice = Invoice()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func open(in viewController : UIViewController , invoice : Invoice){
        let vc = InvoiceDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
        vc.invoice = invoice
        viewController.present(vc, animated: true, completion: nil)
    }

   
}

extension InvoiceDetailsViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  section {
        case 0:
            return invoice.elements.count
        case 1  , 2 , 3 , 5:
            return 1
        case 4:
            return 3 + invoice.adjustments.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ElementTableViewCell") as? ElementTableViewCell
            cell?.setData(item: invoice.elements[indexPath.row])
            return cell ?? UITableViewCell()
        case 1, 2, 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "details") as? BasicInvoiceItemTableViewCell
            switch indexPath.section {
            case 1:
                cell?.setData(details: invoice.timestamp)
                break
            case 2:
                cell?.setData(details: invoice.paymentMethod)
                break
            case 3:
                cell?.setData(details: invoice.recipientName + "\n" + invoice.address.street1 + "\n" + [invoice.address.city , invoice.address.state , invoice.address.postalCode].joined(separator: ", "))
                break
            default:
                break
            }
            return cell ?? UITableViewCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInvoiceItemTableViewCell") as? BasicInvoiceItemTableViewCell
            switch indexPath.row {
            case 0:
                cell?.setData(title: "Subtotal", details: "\(invoice.summery.subTotal)")
                break
            case 1:
                cell?.setData(title: "Delivery", details: "\(invoice.summery.shippingCost)")
                break
            case 2:
                cell?.setData(title: "Estimates tax", details: "\(invoice.summery.totalTax)")
                break
            default:
                let nIndex =  indexPath.row - 3
                if nIndex < invoice.adjustments.count{
                    cell?.setData(title: invoice.adjustments[nIndex].name, details: "\(invoice.adjustments[nIndex].amount)")
                }
            }
            return cell ?? UITableViewCell()
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInvoiceItemTableViewCell") as? BasicInvoiceItemTableViewCell
            cell?.setData(title: "Total", details: "\(invoice.summery.totalCost)")
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

    
}
extension InvoiceDetailsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 5{
            let header = tableView.dequeueReusableCell(withIdentifier: "header") as? BasicInvoiceItemTableViewCell
            switch section {
            case 0:
                header?.setData(title: "Items".uppercased() )
                break
            case 1:
                header?.setData(title: "Ordered on".uppercased() )
                break
            case 2:
                header?.setData(title: "Paid with".uppercased() )
                break
            case 3:
                header?.setData(title: "Ship to".uppercased() )
                break
            case 4:
                header?.setData(title: "Summary".uppercased() )
                break
            default:
                break
            }
            return header
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 5 {
            return 8
        }else{
            return 30
        }
    }
}
