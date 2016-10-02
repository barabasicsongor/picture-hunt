//
//  PostDetailViewController.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import SDWebImage

protocol PostDetailViewControllerDelegate: class {
	func didPressBackButton()
}

class PostDetailViewController: UIViewController {

	// MARK: - Properties
	
	weak var delegate: PostDetailViewControllerDelegate?
	
	fileprivate var post: Post!
	fileprivate var scrollView: UIScrollView!
	fileprivate var contentView: UIView!
	fileprivate var image: UIImageView!
	fileprivate var titleLabel: UILabel!
	fileprivate var photoButton: UIButton!
	fileprivate var imagePicker: UIImagePickerController!
	
	// MARK: - Lifecycle
	
	init(post: Post) {
		super.init(nibName: nil, bundle: nil)
		self.post = post
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()
    }
	
	// MARK: - UI
	
	fileprivate func setupUI() {
		scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(scrollView)
		
		contentView = UIView()
		contentView.backgroundColor = Color.background
		contentView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(contentView)
		
		image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.sd_setImage(with: URL(string: post.imageURL))
		contentView.addSubview(image)
		
		titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.text = post.title
		titleLabel.textAlignment = .center
		titleLabel.numberOfLines = 0
		titleLabel.lineBreakMode = .byWordWrapping
		titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20.0)
		contentView.addSubview(titleLabel)
		
		photoButton = UIButton(type: .custom)
		photoButton.setImage(UIImage(named: "capture_button"), for: .normal)
		photoButton.translatesAutoresizingMaskIntoConstraints = false
		photoButton.addTarget(self, action: #selector(captureButtonTouch), for: .touchUpInside)
		contentView.addSubview(photoButton)
		
		var constraints: [NSLayoutConstraint] = []
		let views: [String: UIView] = ["scrollView": scrollView,
		             "contentView": contentView,
		             "image": image,
		             "titleLabel": titleLabel,
		             "photoButton": photoButton]
		
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: views))
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views))
		
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(>=scrollView)]|", options: [], metrics: nil, views: views))
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(==scrollView)]|", options: [], metrics: nil, views: views))
		
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[image]|", options: [], metrics: nil, views: views))
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(200)]-10-[titleLabel]-30-[photoButton]", options: [], metrics: nil, views: views))
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[titleLabel]-10-|", options: [], metrics: nil, views: views))
		constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[photoButton]-15-|", options: [], metrics: nil, views: views))
		
		
		NSLayoutConstraint.activate(constraints)
	}
	
	// MARK: - Callbacks
	
	@objc fileprivate func captureButtonTouch() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = .camera
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		}
	}

}

extension PostDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CaptureViewController") as! CaptureViewController
		vc.image = chosenImage
		
		dismiss(animated: true, completion: nil)
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
