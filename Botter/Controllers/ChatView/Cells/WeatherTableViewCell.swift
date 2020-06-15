//
//  WeatherTableViewCell.swift
//  Botter
//
//  Created by Nora on 6/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import UIKit

class WeatherTableViewCell: BotChatTableViewCell {

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
    
    override func setData(msg: BasicMessage, showIcon: Bool = false) {
        super.setData(msg: msg, showIcon: showIcon)
        areaLbl.text = msg.weather.area
        dateLbl.text = Date().getWeekDay() + ", " + Date().getWeatherDateString()
        tempLbl.text = msg.weather.temp + "°"
        hieghTempLbl.text = "Lo " + msg.weather.heighTemp
        lowTempLbl.text = "Hi " + msg.weather.lowTemp
        img?.sd_setShowActivityIndicatorView(true)
               img?.sd_setIndicatorStyle(.white)
        img?.sd_setImage(with: URL.init(string: msg.weather.imageUrl), completed: nil)
    }

}
