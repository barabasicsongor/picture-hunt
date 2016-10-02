//
//  AuthenticationService.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import Quickblox

class AuthService {
	
	func mainSetup() {
		QBSettings.setApplicationID(47744)
		QBSettings.setAuthKey("zSVsWBA5RW5J5OF")
		QBSettings.setAuthSecret("sGcOUT4gfKRY7h3")
		QBSettings.setAccountKey("BzooWzwTr1fqpkxDyrPs")
	}
	
	func addUser(withEmail email: String) {
		let user = QBUUser()
		user.login = email
		user.email = email
		user.password = "password"
		
		UserDefaults.standard.set(email, forKey: Defaults.lastUser)
		
		QBRequest.signUp(user, successBlock: nil, errorBlock: nil)
	}
	
	func logIn(withEmail email: String) {
		QBRequest.logIn(withUserLogin: email, password: "password", successBlock: {response, result in}, errorBlock: {error in})
	}
	
	func isLoggedIn() -> Bool {
		let username = UserDefaults.standard.string(forKey: Defaults.lastUser)
		
		if username!.characters.count > 0 {
			logIn(withEmail: username!)
			return true
		} else {
			return false
		}
	}
	
}
