//
//  SettingsViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    fileprivate var titleArray: [String]!
    fileprivate var dataArray: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleArray = ["E-mail","Arrows"]
        dataArray = ["bbbc@bb.com","100"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.propertyLabel.text = titleArray[indexPath.row]
        cell.valueLabel.text = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50.0)
        header.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 10, width: self.view.frame.size.width-30.0, height: 50.0)
        label.text = "User info"
        label.textColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
        header.addSubview(label)
        
        return header
    }
}
