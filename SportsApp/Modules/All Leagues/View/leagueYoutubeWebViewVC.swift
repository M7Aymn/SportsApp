//
//  leagueYoutubeWebViewVC.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 15/08/2024.
//

import UIKit
import WebKit

class leagueYoutubeWebViewVC: UIViewController {
    #warning("check later if we can make it on storyboard and make module for it")
    var urlString: String?
        private var webView: WKWebView!

        override func viewDidLoad() {
            super.viewDidLoad()
            webView = WKWebView(frame: view.bounds)
            view.addSubview(webView)
            
            if let urlString = urlString, let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
}
