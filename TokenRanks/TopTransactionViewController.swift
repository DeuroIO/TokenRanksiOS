//
//  TopTransactionViewController.swift
//  
//
//  Created by Gelei Chen on 15/9/2017.
//
//

import UIKit
import MMDrawerController
import MBProgressHUD

class TopTransactionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var transactions : [TopTokenTransaction] = [] {
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
        loadingHud = Tool.showMiddleHint("Loading Transaction", shouldHide: false)
        refreshControl.beginRefreshing()
        APIFactory.sharedInstance.requestTopTokenTransactions(timestamp: Constant.getDateInString(date: Constant.currentDate), coin_address: Constant.currentToken!.contract_address) { (transactions) in
            self.isLoadingData = false
            self.loadingHud.hide(animated: true)
            self.refreshControl.endRefreshing()
            if let m_transactions = transactions {
                self.transactions = m_transactions
            }
        }
    }
    
    var loadingHud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = refreshControl
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ">", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TopTransactionViewController.nextdateSelected))
        self.navigationItem.setLeftBarButtonItems([MMDrawerBarButtonItem(target: self, action: #selector(TopTransactionViewController.leftBarClicked)),UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TopTransactionViewController.prevDateSelected))], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(TopTransactionViewController.loadData), name: NSNotification.Name(rawValue: Constant.didGetAllTheTokens), object: nil)
        loadData()
        // Do any additional setup after loading the view.
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
            Constant.currentDate = nextDate
            loadData()
        } else {
            
        }
        
    }
    func prevDateSelected(){
        if let prevDate = Calendar.current.date(byAdding: .day, value: -1, to: Constant.currentDate) {
            Constant.currentDate = prevDate
            loadData()
        } else {
            
        }
        
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
