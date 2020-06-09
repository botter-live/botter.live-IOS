//
//  WebLinksViewController.swift
//  ADSC
//
//  Created by Amr Ahmed on 9/26/19.
//  Copyright © 2019 SherifShokry. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class WebLinksViewController: UIViewController , WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView : WKWebView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        self.indicator.startAnimating()
        self.loadWebView()
  }
    
    static func openInParent(link : String , parent : UIViewController){
           let vc = WebLinksViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
           vc.link = link
           parent.present(vc, animated: true, completion: nil)
       }
    
    private func loadWebView(){
        if let url = URL.init(string: link) {
            let urlRequest = URLRequest(url: url )
            webView.load(urlRequest)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       indicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicator.stopAnimating()
    }
    
}
