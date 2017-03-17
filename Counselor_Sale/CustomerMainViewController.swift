//
//  CustomerMainViewController.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 3..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit

class CustomerMainViewController: UIViewController, UISearchResultsUpdating {



    @IBOutlet weak var tableView: UITableView!
    var resultsController: UITableViewController!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 3
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = NSLocalizedString("검색어를 입력해 주세요.", comment: "")
        self.tableView.tableHeaderView = searchController.searchBar

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        // 4
        self.definesPresentationContext = true
        // 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //        foundUsers.removeAll()
        //        for user in users{
        //            let userName:String! = user["name"] as? String
        //            if userName.localizedCaseInsensitiveContainsString(searchController.searchBar.text!) {
        //                foundUsers.append(user)
        //                self.resultsController.tableView.reloadData()
        //            }
        //        }
    }
    
    

}


extension CustomerMainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        return cell
    }
    
    
    
}
