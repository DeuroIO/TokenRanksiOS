//
//  ViewController.swift
//  TokenRanks
//
//  Created by Gelei Chen on 14/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit


class TokenHolderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var holders : [TopTokenHolder] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var isLoadingData = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(TokenHolderViewController.loadData),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    func loadData(){
        if isLoadingData {
            return
        }
        isLoadingData = true
        refreshControl.beginRefreshing()
        APIFactory.sharedInstance.requestTopTokenHolder(timestamp: Constant.getCurrentDateInString()) { (holders) in
            self.refreshControl.endRefreshing()
            self.isLoadingData = false
            if let m_holders = holders {
                self.holders = m_holders
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = refreshControl
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.white
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ">", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TokenHolderViewController.dateSelected))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TokenHolderViewController.dateSelected))
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dateSelected(){
        self.title = "Sep 13"
    }

}

