//
//  Picture.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import Foundation
import SwiftyJSON

class Picture: NSObject {
    
    var url: String = ""
    var weather: String = ""
    var address: String = ""
    
    init(json: [String:Any]) {
        super.init()
        url = json["smallImagePath"] as! String
        weather = (json["parameters"] as! [String : Any])["weather"]! as! String
        address = (json["parameters"] as! [String : Any])["address"]! as! String
    }
    
}
