//
//  CustemView.swift
//  SmartAssert
//
//  Created by LokeshReddy on 01/07/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit
@IBDesignable
class CustemView: UIView
{
    @IBInspectable var cornerRad:CGFloat = 0{
        didSet
        {
            self.layer.cornerRadius = cornerRad
        }
    }
    @IBInspectable var boarderRad:CGFloat = 0{
        didSet{
            self.layer.borderWidth = boarderRad
        }
    }
    @IBInspectable var boraderColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0){
        didSet{
            self.layer.borderColor  = boraderColor.cgColor
        }
    }
    @IBInspectable var shadowColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0){
           didSet{
               self.layer.shadowColor  = shadowColor.cgColor
           // self.layer.masksToBounds = false
           }
       }
    @IBInspectable var showOffSet:CGSize = CGSize(width: 0, height: 0){
        didSet{
            self.layer.shadowOffset = showOffSet
        }
    }
    @IBInspectable var shadowOpacity:Float = 0.0{
              didSet{
                  self.layer.shadowOpacity  = shadowOpacity
                //self.layer.shadowOffset = .zero
              }
          }
    @IBInspectable var shadowRadious:CGFloat = 0.0{
                 didSet{
                     self.layer.shadowRadius  = shadowRadious
                   //self.layer.shadowOffset = .zero
                 }
             }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
