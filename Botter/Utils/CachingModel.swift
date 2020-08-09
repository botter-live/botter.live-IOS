//
//  CachingModel.swift
//  ESMA
//
//  Created by Nora on 10/14/18.
//  Copyright © 2018 BlueCrunch. All rights reserved.
//

import Foundation

class CachingModel{
    
    public struct CachingKeys  {
        static var ERROR_LOOKUP_CODE = "5"
        static var DLICENSE_LOOKUP_CODE = "4"
        static var FINE_CODE_LOOKUP_CODE = "6"
        static var GOVERNS_LOOKUP_CODE = "7"
        static var ID_TYPES_LOOKUP_CODE = "9"
        static var LICENES_CATEGORY_LOOKUP_CODE = "10"
        static var PAYMENT_TYPES_LOOKUP_CODE = "11"
        static var REQUEST_STATUS_LOOKUP_CODE = "14"
        static var SITES_LOOKUP_CODE = "15"
        static var SERVICE_TYPE_LOOKUP_CODE = "18"
        static var PLATE_TYPES_LOOKUP_CODE = "12"
        static var COMPLAIN_REASONS_LOOKUP_CODE = "1"
    }
    
    
    static func getCachedData<T : Codable>(CACHE_KEY : String) -> (T)?
    {
        if let value = UserDefaults.standard.value(forKey: CACHE_KEY) as? Data{
            if let data = try? JSONDecoder().decode(T.self , from: value){
                return data
            }
        }
        return nil
    }
    
    static func setCached<T : Codable>(item : T , key : String){
        if let value = try? JSONEncoder().encode(item) {
            UserDefaults.standard.set(value, forKey: key)
        } else {
            UserDefaults.standard.set(nil, forKey: key)
        }
    }
}
