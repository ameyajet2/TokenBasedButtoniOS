//
//  File.swift
//  ConfigReader
//
//  Created by Ameya.Chandratre on 29/04/24.
//

import Foundation
import UIKit

class Button : UIButton {
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.layer.borderColor = UIColor.hexStringToUIColor(hex: buttonPrimaryDefaultBorderColor).cgColor
                self.titleLabel?.textColor = UIColor.hexStringToUIColor(hex: buttonPrimaryDefaultTextColor)
                self.backgroundColor = UIColor.hexStringToUIColor(hex: buttonPrimaryDefaultBorderColor)
                self.setBackgroundColor(color: UIColor.hexStringToUIColor(hex: buttonPrimaryDefaultBackgroundColor), forState: .normal)
            } else {
                self.layer.borderColor = UIColor.hexStringToUIColor(hex: buttonPrimaryDisabledBorderColor).cgColor
                self.titleLabel?.textColor = UIColor.hexStringToUIColor(hex: buttonPrimaryDisabledTextColor)
                self.backgroundColor = UIColor.hexStringToUIColor(hex: buttonPrimaryDisabledBackgroundColor)
                self.setBackgroundColor(color: UIColor.hexStringToUIColor(hex: buttonPrimaryDisabledBackgroundColor), forState: .disabled)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = buttonBaseBorderRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

extension UIColor {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
