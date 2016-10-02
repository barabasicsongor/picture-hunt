//
//  CaptureViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	public var image: UIImage?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		imageView.image = image
	}
	
	// MARK: - Callbacks
	
	@IBAction func sendButtonTouch(_ sender: AnyObject) {
		
	}
	
	

}
