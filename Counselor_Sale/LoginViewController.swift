//
//  ViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 2. 28..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit

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
        emailTxtField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
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
        
        
    }
    
    
    

}

