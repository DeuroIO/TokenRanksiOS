//
//  TopTransactionViewController.swift
//  
//
//  Created by Gelei Chen on 15/9/2017.
//
//

import UIKit

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
    
    var currentDate = Date()

    func loadData(){
        if isLoadingData {
            return
        }
        isLoadingData = true
        refreshControl.beginRefreshing()
        APIFactory.sharedInstance.requestTopTokenTransactions(timestamp: Constant.getDateInString(date: currentDate)) { (transactions) in
            self.isLoadingData = false
            self.refreshControl.endRefreshing()
            if let m_transactions = transactions {
                self.transactions = m_transactions
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ">", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TopTransactionViewController.nextdateSelected))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TopTransactionViewController.prevDateSelected))
        self.navigationItem.title = Constant.getDateInString(date: currentDate)
        loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func nextdateSelected(){
        if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) {
            currentDate = nextDate
            self.navigationItem.title = Constant.getDateInString(date: currentDate)
            loadData()
        } else {
            
        }
        
    }
    func prevDateSelected(){
        if let prevDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) {
            currentDate = prevDate
            self.navigationItem.title = Constant.getDateInString(date: currentDate)
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