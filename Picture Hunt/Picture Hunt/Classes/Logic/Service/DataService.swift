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
	
	fileprivate func parseArray(result: [Any?]) -> [Post] {
		var results: [Post] = []
		for item in result {
			if let obj: QBCOCustomObject = item as? QBCOCustomObject {
				var post = Post()
				post.userID = obj.fields.object(forKey: "userID") as! Int
				post.title = obj.fields.object(forKey: "title") as! String
				post.imageURL = obj.fields.object(forKey: "imageURL") as! String
				post.value = obj.fields.object(forKey: "value") as! Int
				post.postID = obj.fields.object(forKey: "postID") as! Int
				
				results.append(post)
			}
		}
		
		return results
	}
}
