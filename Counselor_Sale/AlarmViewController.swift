//
//  AlarmViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 3..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import TabPageViewController


class AlarmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userSettingBtnTapped(_ sender: Any) {
        
        let tc = TabPageViewController.create()
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstView")
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController")
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "yellowvc")
        
        tc.tabItems = [(vc1, "업무일지"), (vc2, "현장별 명함"), (vc3, "내 소개")]
        
        var option = TabPageOption()
        option.tabWidth = view.frame.width / CGFloat(tc.tabItems.count)
        tc.option = option
        navigationController?.pushViewController(tc, animated: true)
        
    }

}


extension AlarmViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlarmTableViewCell

        cell.label_AlarmComment.text = "Test"
        cell.label_AlarmDate.text = "2017-03-02"
        
        
        return cell
    }
    
    
    
}
