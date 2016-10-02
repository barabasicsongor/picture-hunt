//
//  MainWireframe.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import Quickblox

protocol MainWireframeDelegate: class {
	
	func didLogOut()
}

class MainWireframe {
	
	// MARK: - Properties
	
	weak var delegate: MainWireframeDelegate?
	
	fileprivate var window: UIWindow!
	fileprivate var navigation: UINavigationController?
	fileprivate var mainViewController: MainViewController?
	fileprivate var settingsViewController: SettingsViewController?
	
	// MARK: - Initialization
	
	init(window: UIWindow) {
		self.window = window
	}
	
	// MARK: - Public methods
	
	func startMainFlow() {
		mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
		mainViewController?.delegate = self
		navigation = UINavigationController(rootViewController: mainViewController!)
		setupNavigationController()
		window.rootViewController = navigation
	}
	
	// MARK: - UI
	
	fileprivate func setupNavigationController() {
		navigation?.navigationBar.barTintColor = Color.navigationBar
		navigation?.navigationBar.tintColor = UIColor.white
	}
	
}

extension MainWireframe: MainViewControllerDelegate {
	
	func didPressSettingsButton() {
		settingsViewController = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
		settingsViewController?.delegate = self
		navigation?.pushViewController(settingsViewController!, animated: true)
	}
}

extension MainWireframe: SettingsViewControllerDelegate {
	func didPressBackButton() {
		_ = navigation?.popViewController(animated: true)
		settingsViewController = nil
	}
	
	func didPressLogOutButton() {
		UserDefaults.standard.set("", forKey: Defaults.lastUser)
		UserDefaults.standard.set(0, forKey: Defaults.arrows)
		QBRequest.logOut(successBlock: {success in
			}, errorBlock: nil)
		delegate?.didLogOut()
	}
}
