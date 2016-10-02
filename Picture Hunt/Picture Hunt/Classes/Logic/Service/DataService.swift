//
//  DataService.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit
import Quickblox
import SwiftyJSON

class DataService {
	
	func getPosts(completion: @escaping (_ result: [Post]) -> Void) {
		QBRequest.objects(withClassName: "post", successBlock: { [weak self] request,result in
			guard let strongSelf = self else { return }
			
			let results = strongSelf.parseArray(result: result!)
			
			completion(results)
			}, errorBlock: { error in
			print("Error loading posts")
		})
	}
	
	func getSubmits(completion: @escaping (_ result: [Submit]) -> Void) {
		QBRequest.objects(withClassName: "submit", successBlock: { [weak self] request,result in
			guard let strongSelf = self else { return }
			
			let results = strongSelf.parse(result: result!)
			
			completion(results)
			}, errorBlock: { error in
				print("Error loading posts")
		})
	}
	
	func getCollect() {
		QBRequest.objects(withClassName: "collect", successBlock: { [weak self] request,result in
			guard let strongSelf = self else { return }
			strongSelf.parseCollect(result: result!)
			}, errorBlock: { error in
				print("Error loading posts")
		})
	}
	
	fileprivate func parseCollect(result: [Any?]) {
		let current: String = UserDefaults.standard.object(forKey: Defaults.lastUser)! as! String
		var arrows: Int = UserDefaults.standard.object(forKey: Defaults.arrows) as! Int
		
		for item in result {
			if let obj: QBCOCustomObject = item as? QBCOCustomObject {
				let email = obj.fields.object(forKey: "userEmail") as! String
				
				if email == current {
					let val = obj.fields.object(forKey: "value") as! Int
					arrows = arrows + val
				}
			}
		}
		
		UserDefaults.standard.set(arrows, forKey: Defaults.arrows)
	}
	
	fileprivate func parse(result: [Any?]) -> [Submit] {
		var results: [Submit] = []
		let current: String = UserDefaults.standard.object(forKey: Defaults.lastUser)! as! String
		for item in result {
			if let obj: QBCOCustomObject = item as? QBCOCustomObject {
				let email = obj.fields.object(forKey: "userEmail") as! String
				
				if email == current {
					var submit = Submit()
					submit.imageURL = obj.fields.object(forKey: "imageURL") as! String
					submit.submitUserEmail = obj.fields.object(forKey: "submitUserEmail") as! String
					submit.userEmail = current
					submit.value = obj.fields.object(forKey: "value") as! Int
					results.append(submit)
				}
			}
		}
		
		return results
	}
	
	fileprivate func parseArray(result: [Any?]) -> [Post] {
		var results: [Post] = []
		for item in result {
			if let obj: QBCOCustomObject = item as? QBCOCustomObject {
				var post = Post()
				post.title = obj.fields.object(forKey: "title") as! String
				post.imageURL = obj.fields.object(forKey: "imageURL") as! String
				post.value = obj.fields.object(forKey: "value") as! Int
				post.postID = obj.fields.object(forKey: "postID") as! Int
				post.userEmail = obj.fields.object(forKey: "userEmail") as! String
				
				results.append(post)
			}
		}
		
		return results
	}
}
