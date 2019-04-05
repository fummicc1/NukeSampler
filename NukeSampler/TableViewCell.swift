//
//  TableViewCell.swift
//  NukeSampler
//
//  Created by Fumiya Tanaka on 2019/04/05.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import UIKit
import Nuke
import FirebaseStorage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var storageImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.storageImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
