//
//  AcceptDeclineViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

protocol AcceptDelegate: class {
	func done(index: Int)
}

class AcceptDeclineViewController: UIViewController {
	
	var submit: Submit!
	var index: Int!

	weak var delegate: AcceptDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	}
	
	@IBAction func accept(_ sender: AnyObject) {
		delegate?.done(index: index)
	}
	
	@IBAction func decline(_ sender: AnyObject) {
		delegate?.done(index: index)
	}

}
