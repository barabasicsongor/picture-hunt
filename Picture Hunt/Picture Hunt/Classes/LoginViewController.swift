//
//  LoginViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
	func didPressLoginButton()
	func didPressBackButton()
}

class LoginViewController: UIViewController {
	
	// MARK: - Properties
	
	weak var delegate: LoginViewControllerDelegate?
	
	@IBOutlet weak var textField: UITextField!

	// MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	// MARK: - UI
	
	fileprivate func setupUI() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	// MARK: - Callbacks
	
	@IBAction func backButtonTouch(_ sender: AnyObject) {
		delegate?.didPressBackButton()
	}
	
	func handleTapGesture() {
		if textField.isFirstResponder {
			textField.resignFirstResponder()
		}
	}
	
	@IBAction func loginButtonTouch(_ sender: AnyObject) {
		delegate?.didPressLoginButton()
	}
}
