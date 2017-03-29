//
//  InformationViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 2..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import TabPageViewController

class InformationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var modelHouseArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getModelHouseList()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getModelHouseList() {
    
        let urlString = "http://md.intoin.io/cs/\(UserDefaults.standard.object(forKey: "msg")!)/modelhouse/list"
        let modelHouseListApiURL = URL(string: urlString)
    
        SVProgressHUD.show()
        Alamofire.request(modelHouseListApiURL!, method: .post, parameters : nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode : 200..<300)
            .responseJSON { response in
                
                let result = response.result
                if let dict = result.value as? [[String: AnyObject]] {
                    
                    self.modelHouseArray = dict as [AnyObject]
                    print(dict)
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        SVProgressHUD.dismiss()
                    }
                }
                
        }
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

extension InformationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelHouseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InformationTableViewCell
        
        let modelHouse = modelHouseArray[indexPath.row]
        let title = modelHouse["MODELHOUSE_NAME"]
        let address = modelHouse["SIGONGADDRESS1"]
        if let image = modelHouse as? String {
            if let data = NSData(contentsOf: (NSURL(string: image) as URL?)!){
                cell.informationImageView.image = UIImage(data: data as Data)
            }
        }
        cell.informationTitle.text = title as? String
        cell.informationAddress.text = address as? String
        
        return cell
    }
}
