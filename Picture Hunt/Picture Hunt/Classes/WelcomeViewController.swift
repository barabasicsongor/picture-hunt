//
//  WelcomeViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

protocol WelcomeViewControllerDelegate: class {
	func didPressNextButton()
}

class WelcomeViewController: UIViewController {

	// MARK: - Properties
	
	weak var delegate: WelcomeViewControllerDelegate?
	
	// MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	// MARK: - Callbacks
	
	@IBAction func registerButtonTouch(_ sender: AnyObject) {
		delegate?.didPressNextButton()
	}
	

}
