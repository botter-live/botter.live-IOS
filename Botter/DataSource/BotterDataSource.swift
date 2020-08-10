//
//  BotterDataSource.swift
//  Botter
//
//  Created by Nora on 7/15/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation

class BotterDataSource : BaseDataSource{
    
    func getBotterData(completion:@escaping(ResponseStatus,Any)->Void){
//        let params = ["bot_id" : BotterSettingsManager.BotID]
//        print(Constants.BOTTER_DATA + BotterSettingsManager.BotID)
        BaseAPI(url: Constants.BOTTER_DATA + BotterSettingsManager.BotID  , method: .get , params: nil, headers: nil) { (json, error) in
            if json != nil {
                print(json)
                let data = b_BotData.getBotterData(dict: json ?? [:])
                completion(.sucess , data)
            }else{
                if (error != nil){
                    completion(.networkError , error!.localizedDescription)
                }
                else{
                    completion(.networkError,"Something went wrong!")
                }
            }
        }
        
    }
    
    
    func getFAQsData(searchText: String,completion:@escaping(ResponseStatus,Any)->Void){
    //        let params = ["bot_id" : BotterSettingsManager.BotID]
    //        print(Constants.BOTTER_DATA + BotterSettingsManager.BotID)
        
        let faqUrl = Constants.FAQ_DATA + BotterSettingsManager.BotID + "&search=" + searchText
        
        
         BaseArrayAPI(url: faqUrl , method: .get , params: nil, headers: nil) { (json, error) in
            
            
                if json != nil {
                    print(json)
                    
                    
                    let data = b_FaqData.getFAQS(dict: json ?? [[:]])
                    
                    
                    completion(.sucess , data)
                }else{
                    if (error != nil){
                        completion(.networkError , error!.localizedDescription)
                    }
                    else{
                        completion(.networkError,"Something went wrong!")
                    }
                }
            }
            
        }
    
    
    
    
    
}