//
//  FlightTicketTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/7/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class FlightTicketTableViewCell: BotChatTableViewCell {

    @IBOutlet weak var passengersLbl : UILabel!
    @IBOutlet weak var way1TicketInfo : FlightInfoView!
    @IBOutlet weak var way2TicketInfo : FlightInfoView!
    @IBOutlet weak var bookingNumberLbl : UILabel!
    @IBOutlet weak var totalLbl : UILabel!
    @IBOutlet weak var ticketNumberView : b_AccentView!
    @IBOutlet weak var planeImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
        ticketNumberView.clipsToBounds = true
        ticketNumberView.layer.cornerRadius = 10
        ticketNumberView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        planeImage.tintColor = BotterSettingsManager.FontColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(msg: b_BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        way1TicketInfo.isHidden = msg.flightInfo.tickets.count == 0
        way2TicketInfo.isHidden = msg.flightInfo.tickets.count < 2
        if msg.flightInfo.tickets.count > 0{
            way1TicketInfo.setData(ticket: msg.flightInfo.tickets[0])
        }
        
        if msg.flightInfo.tickets.count > 1{
            way2TicketInfo.setData(ticket: msg.flightInfo.tickets[1])
        }
        
        totalLbl.text = msg.flightInfo.total + " " + msg.flightInfo.currency
        passengersLbl.text = msg.flightInfo.passengers.joined(separator: "\n")
        bookingNumberLbl.text = msg.flightInfo.confirmationNumber
    }
    
    
//    static func register(table : UITableView){
//        let cellNib = UINib(nibName: "FlightTicketTableViewCell", bundle: MyFrameworkBundle.bundle)
//        table.register(cellNib, forCellReuseIdentifier: "FlightTicketTableViewCell")
//    }
}
class FlightInfoView:UIView{
    @IBOutlet weak var stopsLbl : UILabel!
    @IBOutlet weak var deptCityLbl : UILabel!
    @IBOutlet weak var arrCityLbl : UILabel!
    @IBOutlet weak var deptAirportLbl : UILabel!
    @IBOutlet weak var arrAirportLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    
    func setData(ticket:b_TicketInfo){
        stopsLbl.text = ticket.stops
        deptCityLbl.text = ticket.depratureAirPort.city
        deptAirportLbl.text = ticket.depratureAirPort.code
        dateLbl.text = ticket.date
        arrCityLbl.text = ticket.arrivalAirPort.city
        arrAirportLbl.text = ticket.arrivalAirPort.code
    }
}
extension UITableView {
    func registerBotterCellNib(_ cellClass: AnyClass) {
           let identifier = String.b_className(cellClass)
           let nib = UINib(nibName: identifier, bundle: MyFrameworkBundle.bundle)
           self.register(nib, forCellReuseIdentifier: identifier)
       }
}
