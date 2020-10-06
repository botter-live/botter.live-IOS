//
//  AttachmentInputCardTableViewCell.swift
//  Alamofire
//
//  Created by Nora on 9/7/20.
//

import UIKit

class AttachmentInputCardTableViewCell: BotChatTableViewCell {
    
    @IBOutlet weak var errorLbl : UILabel!
    @IBOutlet weak var uploadBtn : UIButton!
    @IBOutlet weak var fileView : UIView!
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var fileNameLbl : UILabel!
    
    var uploadFile : (()->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        errorLbl.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setData(msg : b_BasicMessage ,showIcon : Bool , completion:@escaping(()->())){
//        self.msg = msg
        super.setData(msg: msg, showIcon: showIcon)
        textLbl.text = self.msg.text
        uploadBtn.isHidden = msg.prompt.answered
        fileView.isHidden = !msg.prompt.answered || !(msg.prompt.type == .attachment)
        imgView.isHidden = !msg.prompt.answered || !(msg.prompt.type == .userImage)
        
        uploadFile = {
            completion()
        }
        
        if !imgView.isHidden{
            // setImage
            msg.lazyImage.setCacheSize(self.imgView?.frame.size)
            self.msg.lazyImage.show(imageView: self.imgView!, url: self.msg.prompt.answerText) { (lazyError) in
            }
        }
        
        if !fileView.isHidden{
            //setFileName
            fileNameLbl.text = self.msg.prompt.answerText
        }
    }
    
    @IBAction func uploadClicked(){
        if uploadFile != nil{
            uploadFile()
        }
    }
    
    override func prepareForReuse() {
        self.msg = b_BasicMessage()
        self.imgView?.image = nil
    }
}

class UIViewWithDashedLineBorder: UIView {

    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(roundedRect: rect, cornerRadius: self.b_cornerRadius)

//        UIColor.gray.setFill()
//        path.fill()

        UIColor.gray.setStroke()
        path.lineWidth = 2

        let dashPattern : [CGFloat] = [10, 4]
        path.setLineDash(dashPattern, count: 2, phase: 0)
        path.stroke()
    }
}
