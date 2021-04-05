//
//  DisplayTableViewCell.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 02/04/21.
//

import UIKit
import SDWebImage
class DisplayTableViewCell: UITableViewCell {
let baseImageURL = "http://139.59.83.144:9050/"
    //http://139.59.83.144:9050/uploads/categories/ff75cc85c36ea5b1e60f46fab2e3a8ba7c4de7fa.png
    @IBOutlet weak var img: UIImageView!
    var  result:Banner?{
        didSet{
           // print(result?.artistName as Any)
            print("\(baseImageURL+result!.bannerImage )")
            img.sd_setImage(with: URL(string:baseImageURL+result!.bannerImage  ), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
