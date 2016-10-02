//
//  AddViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import Quickblox
import MBProgressHUD

class AddViewController: UIViewController {
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		self.view.addGestureRecognizer(tapGesture)
    }

	@IBAction func cameraButtonTouch(_ sender: AnyObject) {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = .camera
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	func handleTapGesture() {
		if textField.isFirstResponder {
			textField.resignFirstResponder()
		}
	}
	
	@IBAction func sendButtonTouch(_ sender: AnyObject) {
		MBProgressHUD.showAdded(to: self.view, animated: true)
		
		let title = textField.text
		let imageData = UIImagePNGRepresentation(imageView.image!)
		QBRequest.tUploadFile(imageData!, fileName: title!, contentType: "image/png", isPublic: true, successBlock: {response, blob in
			let object = QBCOCustomObject()
			object.className = "post"
			object.fields.setObject(111, forKey: "userID" as NSCopying)
			object.fields.setObject(title!, forKey: "title" as NSCopying)
			object.fields.setObject(blob.publicUrl()!, forKey: "imageURL" as NSCopying)
			object.fields.setObject(UserDefaults.standard.object(forKey: Defaults.lastUser)!, forKey: "userEmail" as NSCopying)
			object.fields.setObject(10, forKey: "value" as NSCopying)
			object.fields.setObject(10 + UserDefaults.standard.integer(forKey: Defaults.idCounter), forKey: "postID" as NSCopying)
			
			var postID = UserDefaults.standard.integer(forKey: Defaults.idCounter)
			postID = postID + 1
			UserDefaults.standard.set(postID, forKey: Defaults.idCounter)
			
			QBRequest.createObject(object, successBlock: {response, object in
				MBProgressHUD.hide(for: self.view, animated: true)
				_ = self.navigationController?.popViewController(animated: true)
				}, errorBlock: {error in
					
			})
			}, statusBlock: nil, errorBlock: nil)
	}

}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		imageView.image = chosenImage
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
