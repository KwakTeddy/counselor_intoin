//
//  UIFont+ExampleFonts.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func AppleSDGothicNeoBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func AppleSDGothicNeosemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-semiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func AppleSDGothicNeoMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func AppleSDGothicNeoLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }

}
