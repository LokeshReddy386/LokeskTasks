//
//  CollectionViewCellFreshFruits.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 02/04/21.
//

import UIKit
import SDWebImage
class CollectionViewCellFreshFruits: UICollectionViewCell {
    @IBOutlet weak var imageDetails: UIImageView!
    let baseImageURL = "http://139.59.83.144:9050/"
        //http://139.59.83.144:9050/uploads/categories/ff75cc85c36ea5b1e60f46fab2e3a8ba7c4de7fa.png
      //  @IBOutlet weak var img: UIImageView!
        var  result:Banner?{
            didSet{
               // print(result?.artistName as Any)
                print("\(baseImageURL+result!.bannerImage )")
               // lab_Name.text = result?.categoryName
                imageDetails.sd_setImage(with: URL(string:baseImageURL+result!.bannerImage  ), placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
}
