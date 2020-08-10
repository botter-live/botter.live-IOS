//
//  MapTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/17/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: BotChatTableViewCell {
    
    @IBOutlet weak var descLbl : UILabel!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var btn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setData(msg: b_BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        descLbl.text = msg.location.desc
        textLbl.text = msg.location.title
        btn.setTitle(msg.location.btnTitle, for: .normal)
        self.msg.lazyImage.show(imageView: self.img, url: msg.location.imageUrl) { (lazyError) in
            print(lazyError?.localizedDescription)
        }
    }
    
    
    @IBAction func btnPressed(){
        // open in maps app
        let googleMapsInstalled = UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
        if googleMapsInstalled {
            openGoogleMaps()
        }else{
            openAppleMaps()
        }
    }
    
    func openGoogleMaps(){
        UIApplication.shared.open(URL(string: "comgooglemaps-x-callback://" +
            "?daddr=\(msg.location.lat),\(msg.location.long)&driving=bicycling&zoom=17")!)
        
    }
    
    func openAppleMaps(){
        let coordinates = CLLocationCoordinate2DMake(msg.location.lat, msg.location.long)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = msg.location.title
        mapItem.openInMaps(launchOptions: nil)
    }
}
