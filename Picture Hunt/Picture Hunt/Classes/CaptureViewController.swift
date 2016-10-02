//
//  CaptureViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import Quickblox
import MBProgressHUD

class CaptureViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	public var image: UIImage?
	public var post: Post?
	
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
		MBProgressHUD.showAdded(to: self.view, animated: true)
		
		let imageData = UIImagePNGRepresentation(image!)
		let title = "capturedResponse\(post?.postID)"
		
		QBRequest.tUploadFile(imageData!, fileName: title, contentType: "image/png", isPublic: true, successBlock: {response, blob in
			let object = QBCOCustomObject()
			object.className = "submit"
			object.fields.setObject(blob.publicUrl()!, forKey: "imageURL" as NSCopying)
			object.fields.setObject(self.post!.userEmail, forKey: "userEmail" as NSCopying)
			object.fields.setObject(UserDefaults.standard.object(forKey: Defaults.lastUser)!, forKey: "submitUserEmail" as NSCopying)
			object.fields.setObject(10, forKey: "value" as NSCopying)
			
			QBRequest.createObject(object, successBlock: {response, object in
				MBProgressHUD.hide(for: self.view, animated: true)
				_ = self.navigationController?.popViewController(animated: true)
				}, errorBlock: {error in
					
			})
			}, statusBlock: nil, errorBlock: nil)
	}
	
	

}
