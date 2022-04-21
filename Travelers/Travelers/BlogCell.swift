//
//  BlogCell.swift
//  Travelers
//
//  Created by Hossain, Ahmed Muntasir  on 4/21/22.
//

import UIKit

class BlogCell: UITableViewCell {

    @IBOutlet var blogImage: UIImageView!
    @IBOutlet var blogName: UILabel!
    @IBOutlet var authorName: UILabel!
    @IBOutlet var location: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
