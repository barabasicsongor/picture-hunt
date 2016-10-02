//
//  RootWireframe.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

class RootWireframe {
	
	// MARK: - Properties
	
	fileprivate var window: UIWindow!
	fileprivate var loginWireframe: LoginWireframe?
	fileprivate var mainWireframe: MainWireframe?
	
	// MARK: - Lifecycle
	
	init(window: UIWindow) {
		self.window = window
	}
	
	// MARK: - Public methods
	
	func startFlow() {
		
		if AuthService().isLoggedIn() == true {
			// Logged in
			mainWireframe = MainWireframe(window: window)
			mainWireframe?.delegate = self
			mainWireframe?.startMainFlow()
		} else {
			// Not logged in
			loginWireframe = LoginWireframe(window: window)
			loginWireframe?.delegate = self
			loginWireframe?.startLoginFlow()
		}
	}
}

extension RootWireframe: LoginWireframeDelegate {
	func didFinishLoginFlow() {
		mainWireframe = MainWireframe(window: window)
		mainWireframe?.delegate = self
		mainWireframe?.startMainFlow()
		
		loginWireframe = nil
	}
}

extension RootWireframe: MainWireframeDelegate {
	func didLogOut() {
		window.rootViewController = UIViewController()
		startFlow()
	}
}
