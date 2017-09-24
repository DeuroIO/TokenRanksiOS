//
//  ViewController.swift
//  TokenRanks
//
//  Created by Gelei Chen on 14/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit
import MMDrawerController
import MBProgressHUD

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
        if Constant.currentToken == nil {
            return
        }
        isLoadingData = true
        if Constant.currentTokenString.count >= 5 {
            let index = Constant.currentTokenString.index(Constant.currentTokenString.startIndex, offsetBy: 5)
            Constant.currentTokenString = Constant.currentTokenString.substring(to: index)
        }
        self.navigationItem.title = "\(Constant.currentTokenString) \(Constant.getDateInString(date: Constant.currentDate))"
        refreshControl.beginRefreshing()
        loadingHud = Tool.showMiddleHint("Loading Holder", shouldHide: false)
        APIFactory.sharedInstance.requestTopTokenHolder(timestamp: Constant.getDateInString(date: Constant.currentDate), coin_address: Constant.currentToken!.contract_address) { (holders) in
            self.refreshControl.endRefreshing()
            self.loadingHud.hide(animated: true)
            self.isLoadingData = false
            if let m_holders = holders {
                self.holders = m_holders
            }
        }
    }
    
    var loadingHud : MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = refreshControl
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ">", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TokenHolderViewController.nextdateSelected))
        self.navigationItem.setLeftBarButtonItems([MMDrawerBarButtonItem(target: self, action: #selector(TokenHolderViewController.leftBarClicked)),UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TokenHolderViewController.prevDateSelected))], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(TokenHolderViewController.loadData), name: NSNotification.Name(rawValue: Constant.didGetAllTheTokens), object: nil)
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func nextdateSelected(){
        if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: Constant.currentDate) {
            if nextDate > Constant.todayDate {
                Tool.showErrorHint("Next day is > than today not valid")
                return
            }
            Constant.currentDate = nextDate
            loadData()
        } else {
            Tool.showErrorHint("Next day is not valid")
        }
    }
    
    func prevDateSelected(){
        if let prevDate = Calendar.current.date(byAdding: .day, value: -1, to: Constant.currentDate) {
            Constant.currentDate = prevDate
            loadData()
        } else {
            Tool.showErrorHint("Prev day is not valid")
        }
        
    }
}

