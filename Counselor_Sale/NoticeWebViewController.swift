//
//  AlarmWebViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 3..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NoticeWebViewController: UIViewController {

    @IBOutlet weak var noticeImageView: UIImageView!
    @IBOutlet weak var noticeListDate: UILabel!
    @IBOutlet weak var noticeWebview: UIWebView!
    
    var mvo : NoticeList? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNoticeDetail()
        
    }
    
    func fetchNoticeDetail() {
        
        let idx = (mvo!.noticeIdx)!
        let userDefault = UserDefaults.standard.object(forKey: "msg")
        
        let urlString = "http://md.intoin.io/cs/\(userDefault!)/notice/view/\(idx)"
        let noticeDetailApiURL = URL(string: urlString)
        
        SVProgressHUD.show()
        Alamofire.request(noticeDetailApiURL!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                let result = response.result
                if let dict = result.value as? [String : AnyObject] {
                    
                    self.navigationItem.title = dict["TITLE"] as? String
                    self.noticeListDate.text = dict["DATE"] as? String
                    
                    if dict["NOTICE_CATEGORY"] as? String == "system" {
                        self.noticeImageView.image = UIImage(named: "alarm")
                    }
                    
                    self.noticeWebview.loadHTMLString("\(dict["CONTENTS"]!)", baseURL: nil)
                    SVProgressHUD.dismiss()
                }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn_Tapped(_ sender: Any) {
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    

}
