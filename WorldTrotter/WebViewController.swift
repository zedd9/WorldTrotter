//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by 신현욱 on 2021/02/21.
//

import UIKit
import WebKit

class WebViewController : UIViewController
{
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sURL = "https://www.bignerdranch.com"
        let uURL = URL(string: sURL)
        let request = URLRequest(url: uURL!)
        webView.load(request)
    }
}
