//
//  UserImageTableViewCell.swift
//  Botter
//
//  Created by Nora on 7/29/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit
import MapKit

class UserImageTableViewCell: UserChatTableViewCell {
    
    @IBOutlet weak var msgImage : UIImageView?
    @IBOutlet weak var actionBtn : UIButton?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     func setData(msg: b_BasicMessage) {
        super.setData(msg: msg)
        self.msgImage?.image = nil
        if msg.msgType == .userLocation{
            let url = "https://maps.googleapis.com/maps/api/staticmap?center=\(msg.latitude ?? 0.0),\(msg.langtude ?? 0.0)&zoom=13&size=\(Int(self.msgImage?.frame.width ?? 120))x\(Int(self.msgImage?.frame.height ?? 220))&key=\(BotterSettingsManager.googleMapKey)&markers=size:mid%7Ccolor:0xff0000%7C\(msg.latitude ?? 0.0),\(msg.langtude ?? 0.0)"
             self.msg.lazyImage.show(imageView: self.msgImage!, url: url) { (lazyError) in
                        }
            actionBtn?.isHidden = false
        }else{
            actionBtn?.isHidden = true
            msg.lazyImage.setCacheSize(self.msgImage?.frame.size)
            self.msg.lazyImage.show(imageView: self.msgImage!, url: self.msg.mediaUrl) { (lazyError) in
        }
    }
        
    }
    
    @IBAction func openMaps(){
      if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
//        UIApplication.shared.open(!, options: [:], completionHandler: nil)
        if let url = URL(string:"comgooglemaps://?center=\(msg.latitude ?? 0),\(msg.langtude ?? 0)&zoom=12&views=traffic&q=\(msg.latitude ?? 0),\(msg.langtude ?? 0)") {
            UIApplication.shared.open(url, options: [:])
           }
      else {
             //Open in browser
            openInAppleMap()
            }
      }else{
//        print("failed")
//        if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(String(describing: msg.latitude)),\(String(describing: msg.langtude))&directionsmode=driving") {
//            UIApplication.shared.open(urlDestination)
//           }
        openInAppleMap()
      }
    }
    
    func openInAppleMap(){
        let coordinate = CLLocationCoordinate2DMake(msg.latitude ?? 0, msg.langtude ?? 0)
        let region = MKCoordinateRegion.init(center: coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.02))
//            MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = ""
        mapItem.openInMaps(launchOptions: options)
    }
    
   override func prepareForReuse() {
          self.msg = b_BasicMessage()
          self.msgImage?.image = nil
      }
}
