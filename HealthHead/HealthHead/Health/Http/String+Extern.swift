//
//  String+Extern.swift
//  HealthHead
//
//  Created by Mave on 14/11/20.
//  Copyright (c) 2014年 com.gener-tech. All rights reserved.
//

import Foundation
import UIKit
extension String {

    func URLEncoding()->String {
        //Returns a representation of the `String` using a given encoding to determine the percent escapes necessary to convert the `String` into a legal URL string.
        return self.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        /*
        //CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, origString, NULL, NULL, kCFStringEncodingUTF8)
        var string =        CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, self, nil, "!*'();:@&=+$,/?%#[]", CFStringBuiltInEncodings.UTF8.rawValue)
        println(string)
        return string
*/
    }
}