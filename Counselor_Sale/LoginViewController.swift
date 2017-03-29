//
//  ViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 2. 28..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import PasswordTextField

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: LineButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.isEnabled = false
        handleTextField()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func handleTextField() {
        emailTxtField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func textFieldDidChange() {
        guard let email = emailTxtField.text, !email.isEmpty else {
            loginBtn.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            loginBtn.isEnabled = false
            return
        }
        
        loginBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginBtn.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginBtn_Tapped(_ sender: Any) {
        view.endEditing(true)
        
        guard let email = emailTxtField.text, !email.isEmpty else { return }
        guard let password = passwordTxtField.text, !password.isEmpty else { return }
        
        let urlString = "http://md.intoin.io/cs/auth"
        let authApiURL = URL(string: urlString)
        let parameters = [ "user_id": email, "password": password ]
        
        Alamofire.request(authApiURL!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                    
                case .failure(let error):
                    print(error)
                case .success(let value):
                    
                    let json = JSON(value)
                    if let msg = json["msg"].string {
                        UserDefaults.standard.set(msg, forKey: "msg")
                        UserDefaults.standard.synchronize()
                    }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let naviVC = storyboard.instantiateViewController(withIdentifier: "mainTabbar") as! UITabBarController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = naviVC

                }
        }
    }

}

