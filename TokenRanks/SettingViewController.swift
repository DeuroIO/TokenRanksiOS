//
//  SettingViewController.swift
//  TokenRanks
//
//  Created by Gelei Chen on 20/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Token Analytics"
        loadData()
        // Do any additional setup after loading the view.
    }
    var tokens : [Token] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    func loadData(){
        let loadingHud = Tool.showMiddleHint("Loading", shouldHide: false)
        APIFactory.sharedInstance.getAllTokens { (tokens) in
            loadingHud.hide(animated: false)
            if let m_token = tokens {
                if m_token.count != 0 {
                    Constant.currentToken = m_token[0]
                    self.tokens = m_token
                }
            }
            Tool.postToNotificationCenter(name: Constant.didGetAllTheTokens, object: nil, userInfo: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tokens.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tokens[indexPath.row].coin_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Constant.currentToken = tokens[indexPath.row]
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
