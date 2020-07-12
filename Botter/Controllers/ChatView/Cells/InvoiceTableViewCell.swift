//
//  InvoiceTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/9/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import LazyImage

class InvoiceTableViewCell: BotChatTableViewCell {
    
    @IBOutlet weak var invoiceItem1 : InvoiceItemView!
    @IBOutlet weak var invoiceItem2 : InvoiceItemView!
    @IBOutlet weak var moreBtn : UIButton!
    @IBOutlet weak var paidWithLbl : UILabel!
    @IBOutlet weak var addressLbl : UILabel!
    @IBOutlet weak var totalLbl : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(msg: BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        let invoice = msg.invoice
        invoiceItem1.isHidden = invoice.elements.count == 0
        invoiceItem2.isHidden = invoice.elements.count < 2
        if invoice.elements.count > 0{
            invoiceItem1.setData(item: invoice.elements[0])
        }
        if invoice.elements.count > 1{
            invoiceItem2.setData(item: invoice.elements[1])
        }
        
        moreBtn.isHidden = invoice.elements.count < 3
        paidWithLbl.text = invoice.paymentMethod
        addressLbl.text = invoice.address.addressString
        totalLbl.text = "\(invoice.summery.totalCost)"
        
        moreBtn.setTitle("+\(invoice.elements.count - 2) More", for: .normal)
    }
    
}

class InvoiceItemView : UIView{
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var itemTitleLbl : UILabel!
    @IBOutlet weak var itemQuantityLbl : UILabel!
    @IBOutlet weak var itemPriceLbl : UILabel!
    
    var lazyImage = LazyImage()
    
    func setData(item : InvoiceElement){
        self.lazyImage.show(imageView: self.itemImage!, url: item.image) { (lazyError) in
        }
        itemTitleLbl.text = item.title
        itemQuantityLbl.text = "Qty. \(item.quantity)"
        if itemPriceLbl != nil{
            itemPriceLbl.text = item.currency + " \(item.price)"
        }else{
            itemQuantityLbl.text = item.subtitle + " • " + "Qty. \(item.quantity)" + " • " + item.currency + " \(item.price)"
        }
    }
}
