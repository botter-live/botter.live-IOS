//
//  AttachmentDataSource.swift
//  Botter
//
//  Created by Nora on 7/28/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

class AttachmentDataSource : BaseDataSource{
    
    func uploadAttachment(url: String, name:String = "" ,completion:@escaping(ResponseStatus,Any)->Void){
        var data: Data? = nil
        if let urlObj = URL.init(string: url) {
            do {
                data = try Data.init(contentsOf: urlObj )
            }catch{
                
            }
            
            let mime = b_MimeType.init(url: urlObj)
            let nName = name == "" ? urlObj.lastPathComponent : name
            
            if data != nil {
                upload(data: data! , mime: mime.value , name:  nName) { (json, error) in
                    if json != nil {
//                        print(json)
                        let data = b_AttachedFile.getData(dict: json ?? [:])
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
            }else{
                completion(.error , "Corrupted data")
            }
        }else{
            completion(.error , "Corrupted data")
        }
    }
    
    
    func uploadAttachment(image: UIImage,completion:@escaping(ResponseStatus,Any)->Void){
        var data: Data? = nil
        data = image.pngData()
        
        let imageType = ImageFormat.get(from: data!)
        let mime = "image/\(imageType.contentType)"
        
        if data != nil {
            upload(data: data! , mime: mime , name: "img\(Date.timeIntervalSinceReferenceDate).\(imageType.contentType)") { (json, error) in
                if json != nil{
//                    print(json)
                    let data = b_AttachedFile.getData(dict: json ?? [:])
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
        }else{
            completion(.error , "Corrupted data")
        }
    }
}
enum ImageFormat: String {
    case png, jpg, gif, tiff, webp, heic, unknown
}
extension ImageFormat {
    static func get(from data: Data) -> ImageFormat {
        switch data[0] {
        case 0x89:
            return .png
        case 0xFF:
            return .jpg
        case 0x47:
            return .gif
        case 0x49, 0x4D:
            return .tiff
        case 0x52 where data.count >= 12:
            let subdata = data[0...11]

            if let dataString = String(data: subdata, encoding: .ascii),
                dataString.hasPrefix("RIFF"),
                dataString.hasSuffix("WEBP")
            {
                return .webp
            }

        case 0x00 where data.count >= 12 :
            let subdata = data[8...11]

            if let dataString = String(data: subdata, encoding: .ascii),
                Set(["heic", "heix", "hevc", "hevx"]).contains(dataString)
                ///OLD: "ftypheic", "ftypheix", "ftyphevc", "ftyphevx"
            {
                return .heic
            }
        default:
            break
        }
        return .unknown
    }

    var contentType: String {
        return "\(rawValue)"
    }
}
