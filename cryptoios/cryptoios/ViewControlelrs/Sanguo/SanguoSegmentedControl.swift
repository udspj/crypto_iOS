//
//  SanguoSegmentedControl.swift
//  cryptoios
//
//  Created by Chen Yonghui on 2018/11/13.
//  Copyright © 2018 udspj. All rights reserved.
//

import UIKit

@IBDesignable

class SanguoSegmentedControl: UISegmentedControl {
    @IBInspectable var selectedImage :UIImage?
    @IBInspectable var normalImage :UIImage?
    @IBInspectable var selectedTextColor :UIColor = UIColor.white
    @IBInspectable var normalTextColor :UIColor = UIColor.white
    @IBInspectable var dividerWidth :Int = 1
    @IBInspectable var dividerColor :UIColor = UIColor.clear
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup() 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        let imgSelect = selectedImage?.resizableImage(withCapInsets: .zero, resizingMode: .stretch);
        setBackgroundImage(imgSelect, for: .selected, barMetrics: .default)
        
        let img = normalImage?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        setBackgroundImage(img, for: .normal, barMetrics: .default)
        
        setTitleTextAttributes([.foregroundColor : normalTextColor], for: .normal)
        setTitleTextAttributes([.foregroundColor : selectedTextColor], for: .selected)
        
        let dividerSize = CGSize.init(width: dividerWidth, height: 1)
        let dividerImage = coloredImage(color: dividerColor, size: dividerSize)
        
        setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
        
        
    }
    
    func coloredImage(color:UIColor, size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


