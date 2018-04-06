//
//  imageScrollCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 06/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class imageScrollCell: UITableViewCell {
    @IBOutlet weak var ScrolledImage: ZGCarousel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
