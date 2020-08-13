//
//  WeatherTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit


class WeatherTableViewCell: BotChatTableViewCell  {

    @IBOutlet weak var areaLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var tempLbl : UILabel!
    @IBOutlet weak var hieghTempLbl : UILabel!
    @IBOutlet weak var lowTempLbl : UILabel!
    @IBOutlet weak var img : UIImageView!
    
    
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
        areaLbl.text = msg.weather.area
        dateLbl.text = Date().b_getWeekDay() + ", " + Date().b_getWeatherDateString()
        tempLbl.text = msg.weather.temp
//            + "°C"
        hieghTempLbl.text =  msg.weather.heighTemp
        lowTempLbl.text =  msg.weather.lowTemp
        
        
//        self.lazyImage.showWithSpinner(imageView: self.img, url: msg.weather.imageUrl)
        DispatchQueue.main.async {
            self.msg.lazyImage.show(imageView: self.img, url: msg.weather.imageUrl) { (lazyError) in
                print(lazyError?.localizedDescription)
            }
        }
    }
    
}

