//
//  AnalyticsViewController.swift
//  TokenRanks
//
//  Created by Gelei Chen on 24/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit
import MBProgressHUD
import MMDrawerController

class AnalyticsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dailyStat : EtherDeltaDailyStat! {
        didSet {
            
            self.totalBuyEthLabel.text = dailyStat.total_eth_buy.rounded(toPlaces: 3).description  + " ETH / " + dailyStat.total_kyber_buy.rounded(toPlaces: 3).description + " KYC"
            self.totalSellEthLabel.text = dailyStat.total_eth_sell.rounded(toPlaces: 3).description + " ETH / " + dailyStat.total_kyber_sell.rounded(toPlaces: 3).description + " KYC"
            self.AVGPriceLabel.text = dailyStat.avg_price.rounded(toPlaces: 3).description + " KYC/ETH"
        }
    }
    var transactions : [TopEtherDeltaTransaction] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var totalSellEthLabel: UILabel!
    @IBOutlet weak var AVGPriceLabel: UILabel!
    @IBOutlet weak var totalBuyEthLabel: UILabel!
    
    var isLoadingData = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(AnalyticsViewController.loadData),
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
        loadingHud = Tool.showMiddleHint("Loading EtherDelta Top txs", shouldHide: false)
        APIFactory.sharedInstance.requestEtherDeltaDailyStat(timestamp: Constant.getDateInString(date: Constant.currentDate), coin_address: Constant.currentToken!.contract_address) { (stats) in
            if let m_stats = stats {
                self.dailyStat = m_stats[0]
            }
            APIFactory.sharedInstance.requestTopEtherDeltaTransactions(timestamp: Constant.getDateInString(date: Constant.currentDate), coin_address: Constant.currentToken!.contract_address) { (transactions) in
                self.isLoadingData = false
                self.loadingHud.hide(animated: true)
                self.refreshControl.endRefreshing()
                if let m_transactions = transactions {
                    self.transactions = m_transactions
                }
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ">", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AnalyticsViewController.nextdateSelected))
        self.navigationItem.setLeftBarButtonItems([MMDrawerBarButtonItem(target: self, action: #selector(AnalyticsViewController.leftBarClicked)),UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AnalyticsViewController.prevDateSelected))], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(AnalyticsViewController.loadData), name: NSNotification.Name(rawValue: Constant.didGetAllTheTokens), object: nil)
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
