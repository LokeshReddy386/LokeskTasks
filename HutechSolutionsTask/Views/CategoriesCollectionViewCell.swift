//
//  CategoriesCollectionViewCell.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 02/04/21.
//

import UIKit
import SDWebImage
class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lab_Name: UILabel!
    @IBOutlet weak var imageDetails: UIImageView!
    let baseImageURL = "http://139.59.83.144:9050/"
        //http://139.59.83.144:9050/uploads/categories/ff75cc85c36ea5b1e60f46fab2e3a8ba7c4de7fa.png
      //  @IBOutlet weak var img: UIImageView!
        var  result:Categorydatum?{
            didSet{
               // print(result?.artistName as Any)
                print("\(baseImageURL+result!.categoryPicture )")
                lab_Name.text = result?.categoryName
                imageDetails.sd_setImage(with: URL(string:baseImageURL+result!.categoryPicture  ), placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
}
