//
//  NewsViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import SDWebImage
import Quickblox
import MBProgressHUD

class NewsViewController: UIViewController {

	fileprivate var dataService: DataService!
	fileprivate var submits: [Submit]!
	
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		dataService = DataService()
		submits = []
		self.title = "Found"
		
		dataService.getSubmits(completion: { [weak self] result in
			guard let strongSelf = self else { return }
			strongSelf.submits = result
			strongSelf.tableView.reloadData()
			})
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return submits.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
		
		cell.cellImage.sd_setImage(with: URL(string: submits[indexPath.row].imageURL))
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcceptDeclineViewController") as! AcceptDeclineViewController
		vc.delegate = self
		vc.index = indexPath.row
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension NewsViewController: AcceptDelegate {
	func done(index: Int) {
		submits.remove(at: index)
		tableView.reloadData()
		_ = self.navigationController?.popViewController(animated: true)
	}
}
