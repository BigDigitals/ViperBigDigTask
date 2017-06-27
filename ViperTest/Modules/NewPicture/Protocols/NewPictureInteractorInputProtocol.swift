//
//  NewPictureInteractorInputProtocol.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

protocol NewPictureInteractorInputProtocol {
    
    func newPictureRequest(image: UIImage, description: String, hashtag: String, imageInfo:[String:Any])
    
}

protocol NewPictureInteractorOutputProtocol {
    
    func newPictureSuccessRequest()
    func newPictureFailRequest(error: String)
    
}
