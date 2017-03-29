//
//  AlarmViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 3..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import TabPageViewController


class NoticeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var page = 1
    var notices = [NoticeList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNoticeList()
    }
    
    func fetchNoticeList() {
    
        let msg = UserDefaults.standard.object(forKey: "msg")
        let urlString = "http://md.intoin.io/cs/\(msg!)/notice/\(self.page)"
        let apiURL = URL(string: urlString)
        
        let apidata : Data? = try? Data(contentsOf: apiURL!)
        
        do {
            let result = try JSONSerialization.jsonObject(with: apidata!, options: .mutableContainers) as! [[String: AnyObject]]
            
            print(result)
            
            var notice : NoticeList
            
            for list in result {
                
                notice = NoticeList()
                
                if let isNew = list["IS_NEW"] as? Int, let contents = list["CONTENTS"] as? String, let title = list["TITLE"] as? String, let noticeIdx = list["NOTICE_IDX"] as? Int, let date = list["DATE"] as? String {
                    
                    notice.title = title
                    notice.contents = contents
                    notice.date = date
                    notice.noticeIdx = noticeIdx
                    notice.isNew = isNew
                    
                }
                self.notices.append(notice)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
            
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! NoticeTableViewCell
        let path = self.tableView.indexPath(for: cell)
        let param = self.notices[path!.row]
        
        (segue.destination as? NoticeWebViewController)?.mvo = param
    }

}


extension NoticeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeTableViewCell

        let notice = self.notices[indexPath.row]
        if notice.isNew != 0 {
            
            cell.label_AlarmComment.text = notice.contents
            cell.label_AlarmDate.text = notice.date
            
        } else {
            cell.label_AlarmComment.text = notice.contents
        }
        
        return cell
    }
    
    
    
}
