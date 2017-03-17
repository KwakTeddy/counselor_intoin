//
//  FindPasswordViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 2. 28..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var idTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func backBtn_Tapped(_ sender: Any) {
        
        // Return to the login screen
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    @IBAction func confirmBtn_Tapped(_ sender: Any) {
        view.endEditing(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
