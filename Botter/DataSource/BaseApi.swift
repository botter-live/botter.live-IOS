//
//  BaseApi.swift
//  ADSC
//
//  Created by SherifShokry on 8/6/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import Foundation
import Alamofire

class BaseDataSource : Any {
    
    struct  Constants {
        
        static var BASE_URL = "https://gamma-api.botter.live/widget/"
        static var BOTTER_DATA = BASE_URL + "data/en_US?bot_id="
        
    }
    
    public enum ResponseStatus: String {
        case error = "error"
        case sucess = "success"
        case networkError = "networkError"
    }
    
    func BaseAPI(url:String , method: HTTPMethod,params:[String:Any]? , headers :[String:Any]? ,completion:@escaping([String:Any]?,Error?)->Void){
        
        AF.request(url, method: method, parameters:params, encoding:JSONEncoding.default, headers: HTTPHeaders.init(headers as? [String : String] ?? [:]))
            .responseJSON { (response) in
                switch(response.result){
                case .success(_):
                    let json = response.value as? [String: Any]
                    completion(json,nil)
                    break
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                    completion(nil,response.error)
                    break
                }
        }
    }
    
    
}
