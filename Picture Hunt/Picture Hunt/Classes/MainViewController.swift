//
//  MainViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import SDWebImage

// TODO: - NVIndicatorView addition

protocol MainViewControllerDelegate: class {
	func didPressSettingsButton()
}

class MainViewController: UIViewController {
	
	// MARK: - Properties
	
	weak var delegate: MainViewControllerDelegate?
	
	@IBOutlet weak var tableView: UITableView!
	
	fileprivate var posts: [Post]!
	fileprivate var dataService: DataService!
	fileprivate var overlayView: UIView!
	fileprivate var addButton: UIButton!
	
	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		posts = []
		dataService = DataService()
		setupUI()
		
		self.title = "Treasures"
    }
	
	override func viewWillAppear(_ animated: Bool) {
		loadData()
	}
	
	// MARK: - UI
	
	fileprivate func setupUI() {
		tableView.sectionHeaderHeight = 0.0
		tableView.sectionFooterHeight = 0.0
		
		let btnName = UIButton()
		btnName.setImage(UIImage(named: "settings_icon"), for: .normal)
		btnName.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
		btnName.addTarget(self, action: #selector(settingsButtonTouch), for: .touchUpInside)
		
		let btnName1 = UIButton()
		btnName1.setImage(UIImage(named: "news_icon"), for: .normal)
		btnName1.frame = CGRect(x: 0,y: 0,width: 35,height: 35)
		btnName1.tintColor = UIColor.white
		btnName1.addTarget(self, action: #selector(newsButtonTouch), for: .touchUpInside)
		
		let rightBarButton = UIBarButtonItem()
		rightBarButton.customView = btnName
		self.navigationItem.rightBarButtonItem = rightBarButton
		
		let leftBarButton = UIBarButtonItem()
		leftBarButton.customView = btnName1
		self.navigationItem.leftBarButtonItem = leftBarButton
		
		overlayView = UIView(frame: UIScreen.main.bounds)
		overlayView.backgroundColor = UIColor.clear
		overlayView.isUserInteractionEnabled = false
		self.view.addSubview(overlayView)
		
		addButton = UIButton(type: .custom)
		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.setImage(UIImage(named: "plus_button"), for: .normal)
		addButton.addTarget(self, action: #selector(addButtonTouch), for: .touchUpInside)
		self.view.addSubview(addButton)
		
		var constraints: [NSLayoutConstraint] = []
		
		constraints.append(addButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: -15.0))
		constraints.append(addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15.0))
		NSLayoutConstraint.activate(constraints)
	}
	
	// MARK: - Callbacks
	
	@objc fileprivate func settingsButtonTouch() {
		delegate?.didPressSettingsButton()
	}
	
	@objc fileprivate func newsButtonTouch() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc fileprivate func addButtonTouch() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: - Helper methods
	
	fileprivate func loadData() {
		posts = []
		dataService.getPosts(completion: { [weak self] result in
			guard let strongSelf = self else { return }
			strongSelf.posts = result
			strongSelf.tableView.reloadData()
			})
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
		
		cell.backgroundColor = Color.background
		cell.titleLabel.text = posts[indexPath.row].title
		let url = URL(string: posts[indexPath.row].imageURL)
		cell.cellImage.sd_setImage(with: url, completed: nil)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let vc = PostDetailViewController(post: posts[indexPath.row])
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
