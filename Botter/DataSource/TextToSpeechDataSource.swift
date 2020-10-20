//
//  TextToSpeechDataSource.swift
//  Botter
//
//  Created by Nora on 10/18/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation


class TextToSpeechDataSource : BaseDataSource{
    
    
    internal func getLangStr()->String{
        return BotterSettingsManager.language == .arabic ? "ar-XA" : "en_US"
    }
    
    internal func getVoiceStr()->String{
        return BotterSettingsManager.language == .arabic ? "ar-XA-Wavenet-C" : "en-US-Wavenet-D"
    }
    
    func getVoiceFile(text : String , completion:@escaping(ResponseStatus,Any)->Void){
        
        let params = [
            "audioConfig": [
                "audioEncoding" : "MP3" ,
                "pitch" : 0 ,
                "speakingRate" : 1 ,
            ],
            "input" : [
                "text" : text
            ] ,
            "voice" : [
                "languageCode" : getLangStr() ,
                "name" : getVoiceStr()
            ] ] as [String : Any]
        
        let header = ["X-Goog-Api-Key":"AIzaSyDQOGzxRHVC-vgTCbHq946G_8Pdw9dEh_E"]
        
        print(params as? AnyObject)
        
        BaseAPI(url: Constants.TEXT_TO_SPEECH , method: .post , params: params, headers: header) { (json, error) in
                if let json = json {
                    print(json)
//                    let data = b_FaqData.getFAQS(dict: json ?? [[:]])
                    if let fileStr = json["audioContent"] as? String{
                        completion(.sucess , fileStr)
                    }
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
