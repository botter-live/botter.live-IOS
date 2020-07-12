//
//  FlightStatusTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/8/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class FlightStatusTableViewCell: BotChatTableViewCell {
    
    @IBOutlet weak var flightLbl : UILabel!
    @IBOutlet weak var arrivsLbl : UILabel!
    @IBOutlet weak var departsLbl : UILabel!
    @IBOutlet weak var arrCodeLbl : UILabel!
    @IBOutlet weak var depCodeLbl : UILabel!
    @IBOutlet weak var arrNameLbl : UILabel!
    @IBOutlet weak var depNameLbl : UILabel!
    @IBOutlet weak var statusLbl : UILabel!

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
        let fs = msg.flighStatus
        flightLbl.text = fs.flight
        arrivsLbl.text = fs.arrives
        departsLbl.text = fs.departs
        arrCodeLbl.text = fs.arrivalAirportCode
        depCodeLbl.text = fs.depratureAirportCode
        arrNameLbl.text = fs.arrivalAirportName
        depNameLbl.text = fs.depratureAirportName
        statusLbl.text = fs.status
    }
}
