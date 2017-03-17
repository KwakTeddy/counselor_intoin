//
//  InformationTableViewCell.swift
//  Counselor_Sale
//
//  Created by Teddy Kwak on 2017. 3. 3..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var informationImageView: UIImageView!
    @IBOutlet weak var informationTitle: UILabel!
    @IBOutlet weak var informationAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
