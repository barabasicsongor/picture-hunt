//
//  MainWireframe.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

protocol MainWireframeDelegate: class {
}

class MainWireframe {
	
	// MARK: - Properties
	
	weak var delegate: MainWireframeDelegate?
	
	fileprivate var window: UIWindow!
	fileprivate var navigation: UINavigationController?
	fileprivate var mainViewController: MainViewController?
	
	// MARK: - Initialization
	
	init(window: UIWindow) {
		self.window = window
	}
	
	// MARK: - Public methods
	
	func startMainFlow() {
		mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
		navigation = UINavigationController(rootViewController: mainViewController!)
		setupNavigationController()
		window.rootViewController = navigation
	}
	
	// MARK: - UI
	
	fileprivate func setupNavigationController() {
		navigation?.navigationBar.barTintColor = Color.navigationBar
	}
}
