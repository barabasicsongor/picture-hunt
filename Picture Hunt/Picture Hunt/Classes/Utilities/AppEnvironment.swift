//
//  File.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

class AppEnvironment {
	
	// MARK: - Public methods
	
	func setup() {
		setupUserDefaults()
	}
	
	// MARK: - Private methods
	
	fileprivate func setupUserDefaults() {
		let dictionary = [Defaults.loggedIn: false]
		UserDefaults.standard.register(defaults: dictionary)
	}
	
}
