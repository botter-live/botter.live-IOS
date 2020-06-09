//
//  ImagePickerViewController.swift
//  Masters
//
//  Created by Nora on 3/12/19.
//  Copyright © 2019 BlueCrunch. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ImagePickerViewController: UIViewController {

    let imagepicker = UIImagePickerController()
    var imageString = ""
    var completion : ((UIImage , String)->())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func openUploadImageBottomSheet(withTitle string : String)
    {
        let picker = CustomPickerView()
        let options = ["معرض الصور" , "التقط صورة"]
        picker.selectedIndex = -1
        picker.titleText = string
        picker.subTitleText = ""
        picker.listSource = options
        picker.doneSelectingAction = { index in
            index == 0 ? self.openGallary() : self.checkCamerAccess()
        }
        picker.show()
    }
    
    func openGallary()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
            self.imagepicker.allowsEditing = false
            self.imagepicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagepicker.mediaTypes = [(kUTTypeImage as String)]
            self.present(self.imagepicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Can't find photo Library".localize(), message: "This device doesn't have photo Library".localize(), preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK".localize(), style:.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGifGallary()
       {
           if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
               self.imagepicker.allowsEditing = false
               self.imagepicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagepicker.mediaTypes = [(kUTTypeGIF as String)]
               self.present(self.imagepicker, animated: true, completion: nil)
           }else{
               let alert = UIAlertController(title: "Can't find photo Library".localize(), message: "This device doesn't have photo Library".localize(), preferredStyle: .alert)
               let ok = UIAlertAction(title: "OK".localize(), style:.default, handler: nil)
               alert.addAction(ok)
               self.present(alert, animated: true, completion: nil)
           }
       }
    
    func checkCamerAccess()
    {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                    DispatchQueue.main.async {
                        self.imagepicker.allowsEditing = false
                        self.imagepicker.sourceType = UIImagePickerController.SourceType.camera
                        self.imagepicker.cameraCaptureMode = .photo
                        
                        self.present(self.imagepicker, animated: true, completion: nil)
                    }
                }else{
                    let alert = UIAlertController(title: "Can't find camera".localize(), message: "This device doesn't have camera".localize(), preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok".localize(), style:.default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Camera", message: "Camera access is necessary to capture your photo", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
//           self.setNeedsStatusBarAppearanceUpdate()
       }
//       override var preferredStatusBarStyle : UIStatusBarStyle {
//           return .lightContent
//       }

}
extension ImagePickerViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             guard let selectedImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
//            let image = UIImage.compress(selectedImage)
//             imageString = getImageString(image: image)
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
               print(imageURL.typeIdentifier ?? "unknown UTI")  // this will print public.jpeg or another file UTI
            imageString = imageURL.absoluteString
           }
        self.dismiss(animated: true) {
            if self.completion != nil{
                self.completion(selectedImage , self.imageString)
            }
        }
    }
    
    func getImageString(image : UIImage)->String{
        if image != UIImage(){
            let imageData : NSData = NSData(data: image.jpegData(compressionQuality: 0.5)!)
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
        }else{
            return  ""
        }
    }
}
extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
}
