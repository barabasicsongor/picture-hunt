//
//  SettingsTableViewCell.swift
//  Picture Hunt
//
//  Created by Vilmos Czeroczky on 01/10/2016.
//  Copyright © 2016 Csongor Barabasi. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
