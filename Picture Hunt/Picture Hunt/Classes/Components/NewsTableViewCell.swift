//
//  NewsTableViewCell.swift
//  Picture Hunt
//
//  Created by Csongor Barabasi on 02/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
	
	@IBOutlet weak var cellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
	}
	
}
