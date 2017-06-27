//
//  GifInteractorInputProtocol.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

protocol GifInteractorInputProtocol {
    
    func gifRequest()
    
}

protocol GifInteractorOutputProtocol {
    
    func gifSuccessRequest(picture:Data)
    func gifFailRequest(error: String)
    
}
