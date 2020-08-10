//
//  Invoice.swift
//  Botter
//
//  Created by Nora on 7/8/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class b_Invoice : Mappable{
     
    var address : b_Address
    var currency : String
    var orderNumber : String
    var paymentMethod : String
    var recipientName : String
    var summery : b_InvoiceSummery
    var elements : [b_InvoiceElement]
    var adjustments : [b_InvoiceAdjusment]
    var timestamp : String
    
    init(){
        address = b_Address()
        currency = ""
        orderNumber = ""
        paymentMethod = ""
        recipientName = ""
        summery = b_InvoiceSummery()
        elements = [b_InvoiceElement]()
        adjustments = [b_InvoiceAdjusment]()
        timestamp = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        currency <- map["currency"]
        orderNumber <- map["order_number"]
        paymentMethod <- map["payment_method"]
        recipientName <- map["recipient_name"]
        summery <- map["summary"]
        elements <- map["elements"]
        adjustments <- map["adjustments"]
        timestamp <- map["timestamp"]
    }
}

class b_Address : Mappable{
    var street1 : String
    var street2 : String
    var state : String
    var city : String
    var country : String
    var addressString = ""
    var postalCode : String
    
    
    init() {
        street1 = ""
        street2 = ""
        state = ""
        city = ""
        country = ""
        postalCode = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        street1 <- map["street_1"]
        street2 <- map["street_2"]
        state <- map["state"]
        city <- map["city"]
        country <- map["country"]
        postalCode <- map["postal_code"]
        
        let array : [String] = [street1 , state , city , country]
        addressString = array.joined(separator: ", ")
    }
}

class b_InvoiceElement:Mappable{
    
    
    var currency : String
    var image : String
    var price : Double
    var quantity : Int
    var subtitle : String
    var title : String
    
    init(){
        currency = ""
        image = ""
        price = 0
        quantity = 0
        subtitle = ""
        title = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        currency <- map["currency"]
        image <- map["image_url"]
        price <- map["price"]
        quantity <- map["quantity"]
        subtitle <- map["subtitle"]
        title <- map["title"]
    }
}

class b_InvoiceSummery:Mappable{
    
    var shippingCost : Double
    var subTotal : Double
    var totalCost : Double
    var totalTax : Double
   
    
    init(){
       
        shippingCost = 0
        subTotal = 0
        totalCost = 0
        totalTax = 0
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        shippingCost <- map["shipping_cost"]
        subTotal <- map["subtotal"]
        totalCost <- map["total_cost"]
        totalTax <- map["total_tax"]
    }
}

class b_InvoiceAdjusment:Mappable{
    
    var amount : Double
    var name : String
    
   
    
    init(){
       
        amount = 0
        name = ""
        
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        name <- map["name"]
       
    }
}
