//
//  LoginWireframe.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

protocol LoginWireframeDelegate: class {
	
	func didFinishLoginFlow()
}

class LoginWireframe {
	
	// MARK: - Properties
	
	weak var delegate: LoginWireframeDelegate?
	
	fileprivate var window: UIWindow!
	fileprivate var welcomeViewController: WelcomeViewController?
	fileprivate var loginViewController: LoginViewController?
    fileprivate var settingsVC: SettingsViewController?
	
	// MARK: - Lifecycle
	
	init(window: UIWindow) {
		self.window = window
	}
	
	// MARK: - Public methods
	
	func startLoginFlow() {
		welcomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
		welcomeViewController?.delegate = self
		window.rootViewController = welcomeViewController
	}
	
}

extension LoginWireframe: WelcomeViewControllerDelegate {
	func didPressNextButton() {
		loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
		loginViewController?.delegate = self
		
		UIView.transition(from: welcomeViewController!.view, to: loginViewController!.view, duration: 0.5, options: [.transitionFlipFromRight], completion: {[weak self] finished in
			guard let strongSelf = self else { return }
			strongSelf.window.rootViewController = strongSelf.loginViewController
			})
	}
}

extension LoginWireframe: LoginViewControllerDelegate {
	func didPressLoginButton() {
		delegate?.didFinishLoginFlow()
	}
	
	func didPressBackButton() {
		UIView.transition(from: loginViewController!.view, to: welcomeViewController!.view, duration: 0.5, options: [.transitionFlipFromLeft], completion: {[weak self] finished in
			guard let strongSelf = self else { return }
			strongSelf.window.rootViewController = strongSelf.welcomeViewController
			strongSelf.loginViewController = nil
			})
	}
}
